// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class OrderHistoryScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> orderHistory;
//   final String customerName;
//   final String tableNumber;
//
//   const OrderHistoryScreen({Key? key, required this.orderHistory, required this.customerName, required this.tableNumber}) : super(key: key)
// }
//
// @override
// _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
// }
//
// class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _updateOrderStatus();
//   }
//
//   void _updateOrderStatus() {
//     Timer.periodic(Duration(seconds: 10), (timer) {
//       FirebaseFirestore.instance.collection('Orders').get().then((snapshot) {
//         for (var doc in snapshot.docs) {
//           if (doc['status'] == 'Preparing') {
//             FirebaseFirestore.instance.collection('Orders').doc(doc.id).update({
//               'status': "Ready",
//             });
//           }
//         }
//       });
//     });
//   }
//
//   void _placeOrder(String customerName, String tableNumber, List<Map<String, dynamic>> items) {
//     FirebaseFirestore.instance.collection('Orders').add({
//       'name': customerName,
//       'table': tableNumber,
//       'items': items,
//       'status': 'Preparing',
//       'paid': false,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
//
//   void _showBillDialog(Map<String, dynamic> order, String docId) {
//     var rawItems = order["items"];
//     List<Map<String, dynamic>> items = [];
//
//     if (rawItems is List) {
//       items = rawItems.map((item) => Map<String, dynamic>.from(item)).toList();
//     }
//
//     int totalAmount = items.fold(0, (sum, item) {
//       int price = int.tryParse(item['price']?.toString() ?? '0') ?? 0;
//       int quantity = int.tryParse(item['quantity']?.toString() ?? '0') ?? 0;
//       return sum + (price * quantity);
//     });
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Bill Summary"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ...items.map((item) {
//                 int price = int.tryParse(item['price']?.toString() ?? '0') ?? 0;
//                 int quantity = int.tryParse(item['quantity']?.toString() ?? '0') ?? 0;
//                 int itemTotal = price * quantity;
//                 return Text("${item['name']} x$quantity - ₹$itemTotal");
//               }).toList(),
//               SizedBox(height: 10),
//               Text(
//                 "Total: ₹$totalAmount",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseFirestore.instance
//                     .collection('Orders')
//                     .doc(docId)
//                     .update({'paid': true});
//                 Navigator.pop(context);
//               },
//               child: Text("Pay"),
//             ),
//             TextButton(
//               onPressed: () {
//                 FirebaseFirestore.instance
//                     .collection('Orders')
//                     .doc(docId)
//                     .delete();
//                 Navigator.pop(context);
//               },
//               child: Text("Delete Order"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Order History")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('Orders')
//             .where('customerName', isEqualTo: widget.customerName)
//             .where('tableNumber', isEqualTo: widget.tableNumber)
//             .where('paid', isEqualTo: false)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No Current orders'));
//           }
//
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//               var rawItems = data["items"];
//               List<Map<String, dynamic>> items = [];
//
//               if (rawItems is List) {
//                 items = rawItems.map((item) => Map<String, dynamic>.from(item)).toList();
//               }
//
//               int totalAmount = items.fold(0, (sum, item) {
//                 int price = int.tryParse(item['price']?.toString() ?? '0') ?? 0;
//                 int quantity = int.tryParse(item['quantity']?.toString() ?? '0') ?? 0;
//                 return sum + (price * quantity);
//               });
//
//               String orderItems = items.map((item) => item['name']).join(", ");
//
//               return Card(
//                 margin: EdgeInsets.all(10),
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Customer: ${data['customerName'] ?? 'Unknown'}"),
//                       Text("Table Number: ${data['tableNumber'] ?? 'N/A'}"),
//                       Text("Order: $orderItems"),
//                       Text("Total: ₹$totalAmount"),
//                       Text("Status: ${data['status'] ?? 'Unknown'}"),
//                       Text(
//                         data['paid'] == true ? "Status: Paid" : "Status: Unpaid",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: data['paid'] == true ? Colors.green : Colors.red,
//                         ),
//                       ),
//                       if (data['paid'] != true)
//                         ElevatedButton(
//                           onPressed: () => _showBillDialog(data, doc.id),
//                           child: Text("Make Bill"),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }