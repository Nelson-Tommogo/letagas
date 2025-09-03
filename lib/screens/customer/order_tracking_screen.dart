import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23);
  final Color secondaryColor = const Color(0xFF333333);
  final Color accentColor = const Color(0xFFFFD700);
  final Color lightBackground = const Color(0xFFF8F9FA);

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'OD12345',
      'status': 'Delivered',
      'date': '12 Oct 2023',
      'cylinder': '13kg',
      'price': '\$30',
      'statusColor': Colors.green,
      'deliveryAddress': '123 Main Street, Apartment 4B, Nairobi',
      'deliveryTime': '2:30 PM',
      'paymentMethod': 'Mobile Money',
      'orderPlaced': '11 Oct 2023, 10:15 AM',
      'estimatedDelivery': '12 Oct 2023, 1:00 PM - 3:00 PM',
    },
    {
      'id': 'OD12346',
      'status': 'In Progress',
      'date': '11 Oct 2023',
      'cylinder': '6kg',
      'price': '\$20',
      'statusColor': Colors.orange,
      'deliveryAddress': '456 Oak Avenue, House 12, Nairobi',
      'deliveryTime': '4:45 PM',
      'paymentMethod': 'Cash on Delivery',
      'orderPlaced': '11 Oct 2023, 2:30 PM',
      'estimatedDelivery': '11 Oct 2023, 4:30 PM - 5:30 PM',
    },
    {
      'id': 'OD12347',
      'status': 'Cancelled',
      'date': '10 Oct 2023',
      'cylinder': '13kg',
      'price': '\$30',
      'statusColor': Colors.red,
      'deliveryAddress': '789 Pine Road, Nairobi',
      'deliveryTime': '11:00 AM',
      'paymentMethod': 'Credit Card',
      'orderPlaced': '10 Oct 2023, 9:00 AM',
      'estimatedDelivery': '10 Oct 2023, 10:30 AM - 12:00 PM',
    },
  ];

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          OrderDetailsSheet(order: order, primaryColor: primaryColor),
    );
  }

  void _deleteOrder(int index) {
    setState(() {
      _orders.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${_orders[index]['id']} deleted'),
        backgroundColor: primaryColor,
      ),
    );
  }

  void _clearAllOrders() {
    if (_orders.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Orders'),
          content: const Text(
              'Are you sure you want to clear all order history? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: secondaryColor)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _orders.clear();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('All orders cleared'),
                    backgroundColor: primaryColor,
                  ),
                );
              },
              child: Text('Clear', style: TextStyle(color: primaryColor)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: _orders.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: _clearAllOrders,
                  tooltip: 'Clear all orders',
                ),
              ]
            : null,
      ),
      body: Container(
        color: lightBackground,
        child: _orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: secondaryColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No orders yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: secondaryColor.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your orders will appear here',
                      style: TextStyle(
                        color: secondaryColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => _showOrderDetails(context, order),
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
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color:
                                        order['statusColor'].withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    order['status'],
                                    style: TextStyle(
                                      color: order['statusColor'],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_gas_station,
                                  color: primaryColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Cylinder: ${order['cylinder']}',
                                  style: TextStyle(
                                    color: secondaryColor.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Divider(
                              color: secondaryColor.withOpacity(0.1),
                              height: 1,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order['price'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  order['date'],
                                  style: TextStyle(
                                    color: secondaryColor.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class OrderDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> order;
  final Color primaryColor;

  const OrderDetailsSheet({
    super.key,
    required this.order,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: order['statusColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: order['statusColor'],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Order ID', order['id']),
          _buildDetailRow('Cylinder Size', order['cylinder']),
          _buildDetailRow('Total Price', order['price']),
          _buildDetailRow('Order Placed', order['orderPlaced']),
          _buildDetailRow('Estimated Delivery', order['estimatedDelivery']),
          _buildDetailRow('Delivery Address', order['deliveryAddress']),
          _buildDetailRow('Payment Method', order['paymentMethod']),
          const SizedBox(height: 30),
          if (order['status'] == 'In Progress')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Cancel order functionality
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Order ${order['id']} cancellation requested'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel Order'),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Close'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
