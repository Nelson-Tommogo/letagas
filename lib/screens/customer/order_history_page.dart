import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-001',
        'date': '2024-01-15',
        'status': 'Delivered',
        'items': '13kg Cylinder x1',
        'total': '\$30.00',
        'statusColor': Colors.green,
      },
      {
        'id': 'ORD-002',
        'date': '2024-01-10',
        'status': 'Cancelled',
        'items': '6kg Cylinder x2',
        'total': '\$40.00',
        'statusColor': Colors.red,
      },
      {
        'id': 'ORD-003',
        'date': '2024-01-05',
        'status': 'Delivered',
        'items': '22kg Cylinder x1',
        'total': '\$45.00',
        'statusColor': Colors.green,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
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
                      Chip(
                        label: Text(
                          order['status'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: order['statusColor'],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Date: ${order['date']}'),
                  const SizedBox(height: 4),
                  Text('Items: ${order['items']}'),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        order['total'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFFF05E23),
                        ),
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
