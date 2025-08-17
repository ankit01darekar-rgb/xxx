import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.menuItem != null) {
      _nameController.text = widget.menuItem!['name'] ?? '';
      _priceController.text = widget.menuItem!['price'].toString();
      _imageUrlController.text = widget.menuItem!['image'] ?? '';
      _selectedCategory = widget.menuItem!['category'];
    }
  }

  void _saveMenuItem() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final menuItem = {
        'name': _nameController.text.trim(),
        'price': double.tryParse(_priceController.text.trim()) ?? 0,
        'image': _imageUrlController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Menu Item' : 'Add Menu Item'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              ElevatedButton(
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