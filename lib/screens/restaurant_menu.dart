import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_history_screen.dart';
import 'order_status_screen.dart';

class RestaurantMenu extends StatefulWidget {
  final String customerName;
  final String tableNumber;

  const RestaurantMenu({
    Key? key,
    required this.customerName,
    required this.tableNumber,
  }) : super(key: key);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  final List<String> categories = ["Dals & Curries", "Breads", "Rice", "Fast Food"];
  String selectedCategory = "Dals & Curries";
  Map<String, Map<String, dynamic>> order = {};
  final PageController _pageController = PageController();

  void _addItemToOrder(String itemName, int price) {
    setState(() {
      if (order.containsKey(itemName)) {
        order[itemName]!['quantity'] += 1;
      } else {
        order[itemName] = {'quantity': 1, 'price': price};
      }
    });
  }

  void _updateQuantity(String itemName, int change) {
    setState(() {
      if (order.containsKey(itemName)) {
        order[itemName]!['quantity'] += change;
        if (order[itemName]!['quantity'] <= 0) {
          order.remove(itemName);
        }
      }
    });
  }
  void _placeOrder() async {
    var orderData = {
      'customerName': widget.customerName,
      'tableNumber': widget.tableNumber,
      'items': order.entries.map((entry) => {
        'name': entry.key,
        'quantity': entry.value['quantity'],
        'price': entry.value['price'],
      }).toList(),
      'status': 'Placed',
      'timestamp': FieldValue.serverTimestamp(),
      'paid': false,
    };

    var orderRef = await FirebaseFirestore.instance.collection('Orders').add(orderData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderStatusScreen(orderId: orderRef.id),
      ),
    );
  }

  void _viewOrderHistory() {
    // Navigate to order history screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => OrderHistoryScreen(customerName: widget.customerName, orderHistory: [],),
    //   ),
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Menu"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _viewOrderHistory,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? Colors.orange
                          : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text(categories[index], style: TextStyle(fontSize: 16))),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Menu')
                  .where('category', isEqualTo: selectedCategory)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var menuItems = snapshot.data!.docs;

                if (menuItems.isEmpty) {
                  return Center(child: Text("No items in this category."));
                }

                return PageView.builder(
                  controller: _pageController,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    var item = menuItems[index].data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        Image.network(item['image'], height: 150, errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported, size: 150);
                        }),
                        Text(item['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("₹${item['price']}"),
                        ElevatedButton(
                          onPressed: () => _addItemToOrder(item['name'], item['price']),
                          child: Text("Add to Order"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          Expanded(
            child: ListView(
              children: order.entries.map((entry) {
                return ListTile(
                    title: Text(entry.key),
                    subtitle: Text("Quantity: ${entry.value['quantity']} - ₹${entry.value['price']}"),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                    IconButton(icon: Icon(Icons.remove), onPressed: () => _updateQuantity(entry.key, -1)),
                IconButton(icon: Icon(Icons.add), onPressed: () => _updateQuantity(entry.key, 1)),],
                ),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: _placeOrder,
            child: Text("Place Order"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}