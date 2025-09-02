import 'package:flutter/material.dart';

class VendorOrders extends StatefulWidget {
  const VendorOrders({super.key});

  @override
  State<VendorOrders> createState() => _VendorOrdersState();
}

class _VendorOrdersState extends State<VendorOrders> {
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
    },
    {
      'id': 'OD1002',
      'status': 'In Progress',
      'customer': 'Jane Smith',
      'cylinder': '6kg',
      'price': '\$20',
      'address': '456 Park Ave, Nairobi',
      'statusColor': Colors.blue,
    },
    {
      'id': 'OD1003',
      'status': 'Delivered',
      'customer': 'Mike Johnson',
      'cylinder': '13kg',
      'price': '\$30',
      'address': '789 Oak St, Nairobi',
      'statusColor': Colors.green,
    },
    {
      'id': 'OD1004',
      'status': 'Cancelled',
      'customer': 'Sarah Wilson',
      'cylinder': '22kg',
      'price': '\$45',
      'address': '101 Pine Rd, Nairobi',
      'statusColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Management'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: Text(_filters[index]),
                    selected: _selectedFilter == index,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                            Chip(
                              label: Text(
                                order['status'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: order['statusColor'],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Customer: ${order['customer']}'),
                        const SizedBox(height: 5),
                        Text('Cylinder: ${order['cylinder']}'),
                        const SizedBox(height: 5),
                        Text('Address: ${order['address']}'),
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
                            Row(
                              children: [
                                if (order['status'] == 'Pending')
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Accept'),
                                  ),
                                const SizedBox(width: 10),
                                if (order['status'] == 'In Progress')
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Complete'),
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
}
