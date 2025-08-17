import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_waiter/screens/track_sales_screen.dart';
import 'package:the_waiter/screens/view_order_sceen.dart';

import '../main.dart';
import 'edit_menu_screen.dart';

class AdminDashboard extends StatelessWidget {
  final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Menu');

  void viewOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewOrdersScreen()),
    );
  }

  void editMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditMenuScreen()),
    );
  }

  void trackSales(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => TrackSalesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ElevatedButton(
            onPressed: () => viewOrders(context),
            child: Text("View Orders"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => editMenu(context),
            child: Text("Edit Menu"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => trackSales(context),
            child: Text("Track Sales"),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}