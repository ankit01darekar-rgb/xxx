import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMenuItemScreen extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? menuItem;
  final String? docId;

  AddMenuItemScreen({this.isEdit = false, this.menuItem, this.docId});

  @override
  _AddMenuItemScreenState createState() => _AddMenuItemScreenState();
}

class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = ["Dals & Curries", "Breads", "Rice", "Fast Food"];

  File? _selectedImage;
  String? _imageUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.menuItem != null) {
      _nameController.text = widget.menuItem!['name'] ?? '';
      _priceController.text = widget.menuItem!['price'].toString();
      _imageUrlController.text= widget.menuItem!['image'] ?? '';
      _selectedCategory = widget.menuItem!['category'];
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 800); // change to camera if needed
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  Future<String?> _uploadImage(File image) async {
    try {
      setState(() => _isUploading = true);
      final ref = FirebaseStorage.instance
          .ref()
          .child('menu_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _saveMenuItem() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      String? finalImageUrl = _imageUrl;

      if (_selectedImage != null) {
        finalImageUrl = await _uploadImage(_selectedImage!);
      }

      if (finalImageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload an image')),
        );
        return;
      }
      final menuItem = {
        'name': _nameController.text.trim(),
        'price': double.tryParse(_priceController.text.trim()) ?? 0,
        'image': finalImageUrl,
        'category': _selectedCategory,
      };

      if (widget.isEdit && widget.docId != null) {
        await FirebaseFirestore.instance
            .collection('Menu')
            .doc(widget.docId)
            .update(menuItem);
      } else {
        await FirebaseFirestore.instance.collection('Menu').add(menuItem);
      }

      Navigator.pop(context);
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a category')),
      );
    }
  }
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); },
          ),
        ]),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Menu Item' : 'Add Menu Item'),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImageOptions(),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, height: 150, fit: BoxFit.cover)
                    : _imageUrl != null
                    ? Image.network(_imageUrl!, height: 150, fit: BoxFit.cover)
                    : Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.camera_alt, size: 50),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter item name' : null,
              ),

              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Please enter price' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter image URL' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'Select Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 20),
              _isUploading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _saveMenuItem,
                child: Text(widget.isEdit ? 'Update Item' : 'Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}