import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand colors
    final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
    final Color secondaryColor = const Color(0xFF333333); // Dark gray
    final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
    final Color lightBackground = const Color(0xFFF8F9FA); // Light background

    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-001',
        'date': '2024-01-15',
        'status': 'Delivered',
        'items': '13kg Cylinder x1',
        'total': '\$30.00',
        'statusColor': Colors.green,
        'time': '2:30 PM',
        'deliveryAddress': '123 Main St, Nairobi',
      },
      {
        'id': 'ORD-002',
        'date': '2024-01-10',
        'status': 'Cancelled',
        'items': '6kg Cylinder x2',
        'total': '\$40.00',
        'statusColor': Colors.red,
        'time': '10:15 AM',
        'deliveryAddress': '456 Park Ave, Nairobi',
      },
      {
        'id': 'ORD-003',
        'date': '2024-01-05',
        'status': 'Delivered',
        'items': '22kg Cylinder x1',
        'total': '\$45.00',
        'statusColor': Colors.green,
        'time': '4:45 PM',
        'deliveryAddress': '789 West Rd, Nairobi',
      },
      {
        'id': 'ORD-004',
        'date': '2024-01-02',
        'status': 'Processing',
        'items': '13kg Cylinder x1, Regulator x1',
        'total': '\$35.00',
        'statusColor': Colors.orange,
        'time': '9:20 AM',
        'deliveryAddress': '321 East St, Nairobi',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.white,
        foregroundColor: secondaryColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: Container(
        color: lightBackground,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your order history',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${orders.length} orders',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: secondaryColor,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: order['statusColor'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  order['status'],
                                  style: TextStyle(
                                    color: order['statusColor'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: secondaryColor.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${order['date']} • ${order['time']}',
                                style: TextStyle(
                                  color: secondaryColor.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: secondaryColor.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  order['deliveryAddress'],
                                  style: TextStyle(
                                    color: secondaryColor.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: 16,
                                color: secondaryColor.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  order['items'],
                                  style: TextStyle(
                                    color: secondaryColor.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                order['total'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (order['status'] == 'Delivered')
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle reorder
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Reorder'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
