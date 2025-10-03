import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_waiter/screens/track_sales_screen.dart';
import 'package:the_waiter/screens/view_order_sceen.dart';
import 'edit_menu_screen.dart';
import 'admin_login_screen.dart'; // Make sure this path is correct

class AdminDashboard extends StatelessWidget {
  final CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('Menu');

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackSalesScreen()),
    );
  }

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildDashboardCard(
              context,
              title: "View Orders",
              icon: Icons.list_alt,
              color: Colors.blue,
              onTap: () => viewOrders(context),
            ),
            _buildDashboardCard(
              context,
              title: "Edit Menu",
              icon: Icons.restaurant_menu,
              color: Colors.orange,
              onTap: () => editMenu(context),
            ),
            _buildDashboardCard(
              context,
              title: "Track Sales",
              icon: Icons.bar_chart,
              color: Colors.green,
              onTap: () => trackSales(context),
            ),
            _buildDashboardCard(
              context,
              title: "Logout",
              icon: Icons.logout,
              color: Colors.redAccent,
              onTap: () => logout(context), // Correct logout navigation
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
