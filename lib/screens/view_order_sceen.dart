import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewOrdersScreen extends StatelessWidget {
  final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Orders"),
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final ordersData = snapshot.data!.docs;
          return ListView.builder(
            itemCount: ordersData.length,
            itemBuilder: (context, index) {
              var order = ordersData[index];
              var itemsList = order['items'] != null
                  ? (order['items'] as List).map((item) => item['name']).join(", ")
                  : 'No items';

              return Card(
                child: ListTile(
                  title: Text("Order: $itemsList"),
                  subtitle: Text(
                    "Table: ${order['table']}, "
                        "Name: ${order['name']}, "
                        "Status: ${order['status']}, "
                        "Paid: ${order['paid'] ? 'Yes' : 'No'}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}