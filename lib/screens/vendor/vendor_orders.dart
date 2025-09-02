import 'package:flutter/material.dart';

class VendorOrders extends StatefulWidget {
  const VendorOrders({super.key});

  @override
  State<VendorOrders> createState() => _VendorOrdersState();
}

class _VendorOrdersState extends State<VendorOrders> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

  int _selectedFilter = 0;
  final List<String> _filters = [
    'All',
    'Pending',
    'In Progress',
    'Delivered',
    'Cancelled'
  ];

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'OD1001',
      'status': 'Pending',
      'customer': 'John Doe',
      'cylinder': '13kg',
      'price': '\$30',
      'address': '123 Main St, Nairobi',
      'statusColor': Colors.orange,
      'time': '2 min ago',
    },
    {
      'id': 'OD1002',
      'status': 'In Progress',
      'customer': 'Jane Smith',
      'cylinder': '6kg',
      'price': '\$20',
      'address': '456 Park Ave, Nairobi',
      'statusColor': Colors.blue,
      'time': '30 min ago',
    },
    {
      'id': 'OD1003',
      'status': 'Delivered',
      'customer': 'Mike Johnson',
      'cylinder': '13kg',
      'price': '\$30',
      'address': '789 Oak St, Nairobi',
      'statusColor': Colors.green,
      'time': '2 hours ago',
    },
    {
      'id': 'OD1004',
      'status': 'Cancelled',
      'customer': 'Sarah Wilson',
      'cylinder': '22kg',
      'price': '\$45',
      'address': '101 Pine Rd, Nairobi',
      'statusColor': Colors.red,
      'time': '1 hour ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Management'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: lightBackground,
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(
                        _filters[index],
                        style: TextStyle(
                          color: _selectedFilter == index
                              ? Colors.white
                              : secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: _selectedFilter == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = index;
                        });
                      },
                      selectedColor: primaryColor,
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order ID and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order['id'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  order['time'],
                                  style: TextStyle(
                                    color: secondaryColor.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: order['statusColor'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: order['statusColor'].withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                order['status'],
                                style: TextStyle(
                                  color: order['statusColor'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Order Details
                        _buildDetailRow(Icons.person, order['customer']),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            Icons.local_gas_station, order['cylinder']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.location_on, order['address']),

                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Colors.grey),
                        const SizedBox(height: 16),

                        // Price and Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order['price'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: secondaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                if (order['status'] == 'Pending')
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: const Text('Accept'),
                                  ),
                                const SizedBox(width: 8),
                                if (order['status'] == 'In Progress')
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: const Text('Complete'),
                                  ),
                                if (order['status'] == 'Pending')
                                  const SizedBox(width: 8),
                                if (order['status'] == 'Pending')
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      side: const BorderSide(color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: const Text('Reject'),
                                  ),
                              ],
                            ),
                          ],
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
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: secondaryColor.withOpacity(0.6),
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: secondaryColor.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
