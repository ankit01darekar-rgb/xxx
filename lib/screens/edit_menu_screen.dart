import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_menu_item_screen.dart';

class EditMenuScreen extends StatelessWidget {
  final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Menu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Menu"),
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: menuCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error fetching data"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final menuItems = snapshot.data!.docs;
          if (menuItems.isEmpty) {
            return Center(child: Text("No menu items available."));
          }

          return ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              var menuItem = menuItems[index].data() as Map<String, dynamic>;
              var docId = menuItems[index].id;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: menuItem['imageUrl'] != null
                      ? Image.network(
                    menuItem['imageUrl'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image_not_supported, size: 60),
                  title: Text(menuItem['name'] ?? 'No Name'),
                  subtitle: Text("Price: ₹${menuItem['price'] ?? 'N/A'}\nCategory: ${menuItem['category'] ?? 'Uncategorized'}"),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMenuItemScreen(
                            isEdit: true,
                            menuItem: menuItem,
                            docId: docId,
                          ),
                        ),
                      );
                    },
                    child: Text('Edit'),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMenuItemScreen(isEdit: false),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
    );
  }
}