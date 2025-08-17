import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  final String orderId;

  const FeedbackScreen({required this.orderId});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('Feedback').add({
        'orderId': widget.orderId,
        'feedback': _feedbackController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(labelText: 'Your Feedback'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter feedback' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void navigateToFeedback(BuildContext context, String orderId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FeedbackScreen(orderId: orderId),
    ),
  );
}

// Call this function after payment is completed and user returns to menu screen.
void onPaymentComplete(BuildContext context, String orderId) {
  navigateToFeedback(context, orderId);
}

// The function 'onPaymentComplete' should be integrated at the payment completion stage in the order placement process to trigger the feedback screen.

