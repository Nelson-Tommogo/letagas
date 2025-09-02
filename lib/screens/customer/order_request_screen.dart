import 'package:flutter/material.dart';

class OrderRequestScreen extends StatefulWidget {
  const OrderRequestScreen({super.key});

  @override
  State<OrderRequestScreen> createState() => _OrderRequestScreenState();
}

class _OrderRequestScreenState extends State<OrderRequestScreen> {
  String _selectedCylinderSize = '13kg';
  String _selectedPaymentMethod = 'Cash on Delivery';
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  bool _isSubmitting = false;

  final List<String> cylinderSizes = ['6kg', '13kg', '22kg', '50kg'];
  final List<String> paymentMethods = [
    'Cash on Delivery',
    'Mobile Money',
    'Credit Card'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Gas Delivery'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cylinder Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCylinderSize,
              items: cylinderSizes.map((size) {
                return DropdownMenuItem(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCylinderSize = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Enter your complete delivery address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Special Instructions (Optional)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _instructionsController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Any special instructions for the delivery person',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              items: paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gas Cost:', style: TextStyle(fontSize: 16)),
                Text('\$25',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee:', style: TextStyle(fontSize: 16)),
                Text('\$5',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$30',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 30),
            _isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isSubmitting = true;
                        });

                        // Simulate order submission
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _isSubmitting = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        'PLACE ORDER',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
