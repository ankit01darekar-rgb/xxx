
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_waiter/screens/welcome_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
    options: const FirebaseOptions(
       apiKey: "AIzaSyDNRq5nRDX7h4BpNGbq-qfcWOQjReuQe3Y",
       authDomain: "the-waiter-10f7a.firebaseapp.com",
       projectId: "the-waiter-10f7a",
       storageBucket: "the-waiter-10f7a.firebasestorage.app",
       messagingSenderId: "38690330541",
       appId: "1:38690330541:web:62d8db12793ad67a163324",
       measurementId: "G-LW1B7JD4X4"));
       }else{
        await Firebase.initializeApp();
       }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}
//
// class WelcomeScreen extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _tableController = TextEditingController();
//
//   void _navigateToMenu() {
//     if (_nameController.text.isNotEmpty && _tableController.text.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RestaurantMenu(
//             customerName: _nameController.text,
//             tableNumber: _tableController.text,
//           ),
//         ),
//       );
//     }
//   }
//   void _navigateToAdmin() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AdminDashboard()),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 84, 2, 83)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Welcome to the Restaurant!",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orangeAccent,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: "Enter Your Name",
//                     filled: true,
//                     fillColor: Colors.grey[800],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: TextField(
//                   controller: _tableController,
//                   decoration: InputDecoration(
//                     labelText: "Enter Table Number",
//                     filled: true,
//                     fillColor: Colors.grey[800],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _navigateToMenu,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   textStyle: TextStyle(fontSize: 18),
//                   backgroundColor: Colors.orangeAccent,
//                 ),
//                 child: Text("Okay"),
//               ),
//               TextButton(
//                 onPressed: _navigateToAdmin,
//                 child: Text("Admin Login", style: TextStyle(color: Colors.orangeAccent)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class AdminDashboard extends StatelessWidget {
//   final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Menu');
//
//   void viewOrders(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ViewOrdersScreen()),
//     );
//   }
//
//   void editMenu(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EditMenuScreen()),
//     );
//   }
//
//   void trackSales(BuildContext context) {
//     Navigator.push(context,
//     MaterialPageRoute(builder: (context) => TrackSalesScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin Dashboard"),
//         backgroundColor: Colors.black87,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20),
//         children: [
//           ElevatedButton(
//             onPressed: () => viewOrders(context),
//             child: Text("View Orders"),
//           ),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => editMenu(context),
//             child: Text("Edit Menu"),
//           ),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => trackSales(context),
//             child: Text("Track Sales"),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.black,
//     );
//   }
// }
//
// class EditMenuScreen extends StatelessWidget {
//   final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Menu');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Menu"),
//         backgroundColor: Colors.black87,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: menuCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text("Error fetching data"));
//           }
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           final menuItems = snapshot.data!.docs;
//           if (menuItems.isEmpty) {
//             return Center(child: Text("No menu items available."));
//           }
//
//           return ListView.builder(
//             itemCount: menuItems.length,
//             itemBuilder: (context, index) {
//               var menuItem = menuItems[index].data() as Map<String, dynamic>;
//               var docId = menuItems[index].id;
//
//               return Card(
//                 margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: ListTile(
//                   leading: menuItem['imageUrl'] != null
//                       ? Image.network(
//                           menuItem['imageUrl'],
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         )
//                       : Icon(Icons.image_not_supported, size: 60),
//                   title: Text(menuItem['name'] ?? 'No Name'),
//                   subtitle: Text("Price: ₹${menuItem['price'] ?? 'N/A'}\nCategory: ${menuItem['category'] ?? 'Uncategorized'}"),
//                   isThreeLine: true,
//                   trailing: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AddMenuItemScreen(
//                             isEdit: true,
//                             menuItem: menuItem,
//                             docId: docId,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text('Edit'),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddMenuItemScreen(isEdit: false),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.orange,
//       ),
//       backgroundColor: Colors.black,
//     );
//   }
// }


// class ViewOrdersScreen extends StatelessWidget {
//   final CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("View Orders"),
//         backgroundColor: Colors.black87,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: orders.snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           final ordersData = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: ordersData.length,
//             itemBuilder: (context, index) {
//               var order = ordersData[index];
//               var itemsList = order['items'] != null
//                   ? (order['items'] as List).map((item) => item['name']).join(", ")
//                   : 'No items';
//
//               return Card(
//                 child: ListTile(
//                   title: Text("Order: $itemsList"),
//                   subtitle: Text(
//                     "Table: ${order['table']}, "
//                     "Name: ${order['name']}, "
//                     "Status: ${order['status']}, "
//                     "Paid: ${order['paid'] ? 'Yes' : 'No'}",
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AddMenuItemScreen extends StatefulWidget {
//   final bool isEdit;
//   final Map<String, dynamic>? menuItem;
//   final String? docId;
//
//   AddMenuItemScreen({this.isEdit = false, this.menuItem, this.docId});
//
//   @override
//   _AddMenuItemScreenState createState() => _AddMenuItemScreenState();
// }
//
// class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _imageUrlController = TextEditingController();
//   String? _selectedCategory;
//   final List<String> _categories = ["Dals & Curries", "Breads", "Rice", "Fast Food"];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit && widget.menuItem != null) {
//       _nameController.text = widget.menuItem!['name'] ?? '';
//       _priceController.text = widget.menuItem!['price'].toString();
//       _imageUrlController.text = widget.menuItem!['image'] ?? '';
//       _selectedCategory = widget.menuItem!['category'];
//     }
//   }
//
//   void _saveMenuItem() async {
//     if (_formKey.currentState!.validate() && _selectedCategory != null) {
//       final menuItem = {
//         'name': _nameController.text.trim(),
//         'price': double.tryParse(_priceController.text.trim()) ?? 0,
//         'image': _imageUrlController.text.trim(),
//         'category': _selectedCategory,
//       };
//
//       if (widget.isEdit && widget.docId != null) {
//         await FirebaseFirestore.instance
//             .collection('Menu')
//             .doc(widget.docId)
//             .update(menuItem);
//       } else {
//         await FirebaseFirestore.instance.collection('Menu').add(menuItem);
//       }
//
//       Navigator.pop(context);
//     } else if (_selectedCategory == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a category')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.isEdit ? 'Edit Menu Item' : 'Add Menu Item'),
//         backgroundColor: Colors.black87,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Item Name'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter item name' : null,
//               ),
//               TextFormField(
//                 controller: _priceController,
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter price' : null,
//               ),
//               TextFormField(
//                 controller: _imageUrlController,
//                 decoration: InputDecoration(labelText: 'Image URL'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter image URL' : null,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 decoration: InputDecoration(labelText: 'Select Category'),
//                 items: _categories.map((category) {
//                   return DropdownMenuItem(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCategory = value;
//                   });
//                 },
//                 validator: (value) => value == null ? 'Please select a category' : null,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveMenuItem,
//                 child: Text(widget.isEdit ? 'Update Item' : 'Add Item'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class TrackSalesScreen extends StatefulWidget {
//   @override
//   _TrackSalesScreenState createState() => _TrackSalesScreenState();
// }
//
// class _TrackSalesScreenState extends State<TrackSalesScreen> {
//   DateTimeRange? _dateRange;
//
//   Stream<QuerySnapshot> _getSalesStream() {
//     Query query = FirebaseFirestore.instance.collection('Orders');
//     if (_dateRange != null) {
//       query = query.where('timestamp', isGreaterThanOrEqualTo: _dateRange!.start)
//                    .where('timestamp', isLessThanOrEqualTo: _dateRange!.end);
//     }
//     return query.snapshots();
//   }
//
//   void _pickDateRange() async {
//     DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2022),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _dateRange = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Track Sales'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: _pickDateRange,
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _getSalesStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No sales data found.'));
//           }
//
//           final orders = snapshot.data!.docs;
//           double totalSales = 0;
//           double pendingPayments = 0;
//           int totalOrders = orders.length;
//
//           for (var order in orders) {
//             final data = order.data() as Map<String, dynamic>;
//             totalSales += data['items']
//                 .fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
//             if (!data['paid']) {
//               pendingPayments += data['items']
//                   .fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
//             }
//           }
//
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _summaryCard('Total Sales', totalSales),
//                     _summaryCard('Pending Payments', pendingPayments),
//                     _summaryCard('Total Orders', totalOrders.toDouble()),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: orders.length,
//                   itemBuilder: (context, index) {
//                     final data = orders[index].data() as Map<String, dynamic>;
//                     return ListTile(
//                       title: Text('Table: ${data['table']} - ₹${data['items'].fold(0, (sum, item) => sum + (item['price'] * item['quantity']))}'),
//                       subtitle: Text('Status: ${data['status']} - Paid: ${data['paid'] ? 'Yes' : 'No'}'),
//                       onTap: () {
//                         // Detailed view logic here
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _summaryCard(String title, double value) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('₹${value.toStringAsFixed(2)}'),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class RestaurantMenu extends StatefulWidget {
//   final String customerName;
//   final String tableNumber;
//
//   const RestaurantMenu({
//     Key? key,
//     required this.customerName,
//     required this.tableNumber,
//   }) : super(key: key);
//
//   @override
//   _RestaurantMenuState createState() => _RestaurantMenuState();
// }
//
// class _RestaurantMenuState extends State<RestaurantMenu> {
//   final List<String> categories = ["Dals & Curries", "Breads", "Rice", "Fast Food"];
//   String selectedCategory = "Dals & Curries";
//   Map<String, Map<String, dynamic>> order = {};
//   final PageController _pageController = PageController();
//
//   void _addItemToOrder(String itemName, int price) {
//     setState(() {
//       if (order.containsKey(itemName)) {
//         order[itemName]!['quantity'] += 1;
//       } else {
//         order[itemName] = {'quantity': 1, 'price': price};
//       }
//     });
//   }
//
//   void _updateQuantity(String itemName, int change) {
//     setState(() {
//       if (order.containsKey(itemName)) {
//         order[itemName]!['quantity'] += change;
//         if (order[itemName]!['quantity'] <= 0) {
//           order.remove(itemName);
//         }
//       }
//     });
//   }
//   void _placeOrder() async {
//     var orderData = {
//       'customerName': widget.customerName,
//       'tableNumber': widget.tableNumber,
//       'items': order.entries.map((entry) => {
//         'name': entry.key,
//         'quantity': entry.value['quantity'],
//         'price': entry.value['price'],
//       }).toList(),
//       'status': 'Placed',
//       'timestamp': FieldValue.serverTimestamp(),
//       'paid': false,
//     };
//
//     var orderRef = await FirebaseFirestore.instance.collection('Orders').add(orderData);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OrderStatusScreen(orderId: orderRef.id),
//       ),
//     );
//   }
//
//   void _viewOrderHistory() {
//     // Navigate to order history screen
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OrderHistoryScreen(customerName: widget.customerName, orderHistory: [],),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Restaurant Menu"),
//         backgroundColor: Colors.black87,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.history),
//             onPressed: _viewOrderHistory,
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedCategory = categories[index];
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     decoration: BoxDecoration(
//                       color: selectedCategory == categories[index]
//                           ? Colors.orange
//                           : Colors.deepPurple,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(child: Text(categories[index], style: TextStyle(fontSize: 16))),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('Menu')
//                   .where('category', isEqualTo: selectedCategory)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 var menuItems = snapshot.data!.docs;
//
//                 if (menuItems.isEmpty) {
//                   return Center(child: Text("No items in this category."));
//                 }
//
//                 return PageView.builder(
//                   controller: _pageController,
//                   itemCount: menuItems.length,
//                   itemBuilder: (context, index) {
//                     var item = menuItems[index].data() as Map<String, dynamic>;
//                     return Column(
//                       children: [
//                         Image.network(item['image'], height: 150, errorBuilder: (context, error, stackTrace) {
//                           return Icon(Icons.image_not_supported, size: 150);
//                         }),
//                         Text(item['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                         Text("₹${item['price']}"),
//                         ElevatedButton(
//                           onPressed: () => _addItemToOrder(item['name'], item['price']),
//                           child: Text("Add to Order"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//
//           Expanded(
//             child: ListView(
//               children: order.entries.map((entry) {
//                 return ListTile(
//                   title: Text(entry.key),
//                   subtitle: Text("Quantity: ${entry.value['quantity']} - ₹${entry.value['price']}"),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(icon: Icon(Icons.remove), onPressed: () => _updateQuantity(entry.key, -1)),
//                       IconButton(icon: Icon(Icons.add), onPressed: () => _updateQuantity(entry.key, 1)),
//             , required this.customerName, required this.tableNumber        ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//             ElevatedButton(
//             onPressed: _placeOrder,
//             child: Text("Place Order"),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//



// class OrderHistoryScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> orderHistory;
//   final String customerName;
//   final String tableNumber;
//
//   const OrderHistoryScreen({Key? key, required this.orderHistory, required this.customerName, required this.tableNumber}) : super(key: key)
//   }
//
//   @override
//   _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
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





// class OrderStatusScreen extends StatefulWidget {
//   final String orderId;
//   const OrderStatusScreen({Key? key, required this.orderId}) : super(key: key);
//
//   @override
//   State<OrderStatusScreen> createState() => _OrderStatusScreenState();
// }
//
// class _OrderStatusScreenState extends State<OrderStatusScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Order Status')),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('Orders')
//             .doc(widget.orderId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text("Order not found!"));
//           }
//
//           var orderData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//           var rawItems = orderData["items"];
//
//           // Ensure items is a List of Maps
//           List<Map<String, dynamic>> items = [];
//           if (rawItems is List) {
//             items = rawItems.map((item) => Map<String, dynamic>.from(item)).toList();
//           }
//
//           int totalAmount = items.fold(0, (sum, item) {
//             int price = item['price'] ?? 0;
//             int quantity = item['quantity'] ?? 0;
//             return sum + (price * quantity);
//           });
//
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Order has been placed!",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Total Amount: ₹$totalAmount",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Current Status: ${orderData['status'] ?? 'Unknown'}",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   orderData['paid'] == true ? "Payment: Paid" : "Payment: Unpaid",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: orderData['paid'] == true ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text("Back to Menu"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class FeedbackScreen extends StatefulWidget {
//   final String orderId;
//
//   const FeedbackScreen({required this.orderId});
//
//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _feedbackController = TextEditingController();
//
//   void _submitFeedback() async {
//     if (_formKey.currentState!.validate()) {
//       await FirebaseFirestore.instance.collection('Feedback').add({
//         'orderId': widget.orderId,
//         'feedback': _feedbackController.text.trim(),
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Feedback')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _feedbackController,
//                 decoration: InputDecoration(labelText: 'Your Feedback'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter feedback' : null,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitFeedback,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void navigateToFeedback(BuildContext context, String orderId) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => FeedbackScreen(orderId: orderId),
//     ),
//   );
// }
//
// // Call this function after payment is completed and user returns to menu screen.
// void onPaymentComplete(BuildContext context, String orderId) {
//   navigateToFeedback(context, orderId);
// }
//
// // The function 'onPaymentComplete' should be integrated at the payment completion stage in the order placement process to trigger the feedback screen.
//


