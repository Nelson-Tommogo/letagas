import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'OD12345',
      'status': 'Delivered',
      'date': '12 Oct 2023',
      'cylinder': '13kg',
      'price': '\$30',
      'statusColor': Colors.green,
    },
    {
      'id': 'OD12346',
      'status': 'In Progress',
      'date': '11 Oct 2023',
      'cylinder': '6kg',
      'price': '\$20',
      'statusColor': Colors.orange,
    },
    {
      'id': 'OD12347',
      'status': 'Cancelled',
      'date': '10 Oct 2023',
      'cylinder': '13kg',
      'price': '\$30',
      'statusColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _orders.isEmpty
          ? const Center(
              child: Text(
                'No orders yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order['id'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              order['status'],
                              style: TextStyle(
                                color: order['statusColor'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Cylinder: ${order['cylinder']}'),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              order['date'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
