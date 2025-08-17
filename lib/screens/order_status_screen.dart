import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderStatusScreen extends StatefulWidget {
  final String orderId;
  const OrderStatusScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Status')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .doc(widget.orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Order not found!"));
          }

          var orderData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
          var rawItems = orderData["items"];

          // Ensure items is a List of Maps
          List<Map<String, dynamic>> items = [];
          if (rawItems is List) {
            items = rawItems.map((item) => Map<String, dynamic>.from(item)).toList();
          }

          int totalAmount = items.fold(0, (sum, item) {
            int price = item['price'] ?? 0;
            int quantity = item['quantity'] ?? 0;
            return sum + (price * quantity);
          });

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order has been placed!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Total Amount: ₹$totalAmount",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  "Current Status: ${orderData['status'] ?? 'Unknown'}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  orderData['paid'] == true ? "Payment: Paid" : "Payment: Unpaid",
                  style: TextStyle(
                    fontSize: 18,
                    color: orderData['paid'] == true ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back to Menu"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}