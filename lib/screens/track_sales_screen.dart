import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrackSalesScreen extends StatefulWidget {
  @override
  _TrackSalesScreenState createState() => _TrackSalesScreenState();
}

class _TrackSalesScreenState extends State<TrackSalesScreen> {
  DateTimeRange? _dateRange;

  Stream<QuerySnapshot> _getSalesStream() {
    Query query = FirebaseFirestore.instance.collection('Orders');
    if (_dateRange != null) {
      query = query.where('timestamp', isGreaterThanOrEqualTo: _dateRange!.start)
          .where('timestamp', isLessThanOrEqualTo: _dateRange!.end);
    }
    return query.snapshots();
  }

  void _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Sales'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _pickDateRange,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getSalesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No sales data found.'));
          }

          final orders = snapshot.data!.docs;
          double totalSales = 0;
          double pendingPayments = 0;
          int totalOrders = orders.length;

          for (var order in orders) {
            final data = order.data() as Map<String, dynamic>;
            totalSales += data['items']
                .fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
            if (!data['paid']) {
              pendingPayments += data['items']
                  .fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
            }
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _summaryCard('Total Sales', totalSales),
                    _summaryCard('Pending Payments', pendingPayments),
                    _summaryCard('Total Orders', totalOrders.toDouble()),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final data = orders[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text('Table: ${data['table']} - ₹${data['items'].fold(0, (sum, item) => sum + (item['price'] * item['quantity']))}'),
                      subtitle: Text('Status: ${data['status']} - Paid: ${data['paid'] ? 'Yes' : 'No'}'),
                      onTap: () {
                        // Detailed view logic here
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryCard(String title, double value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('₹${value.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}