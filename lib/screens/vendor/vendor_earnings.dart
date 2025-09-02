import 'package:flutter/material.dart';

class VendorEarnings extends StatefulWidget {
  const VendorEarnings({super.key});

  @override
  State<VendorEarnings> createState() => _VendorEarningsState();
}

class _VendorEarningsState extends State<VendorEarnings> {
  String _selectedTimeframe = 'This Month';

  final List<String> _timeframes = [
    'Today',
    'This Week',
    'This Month',
    'This Year'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: _selectedTimeframe,
              items: _timeframes.map((timeframe) {
                return DropdownMenuItem(
                  value: timeframe,
                  child: Text(timeframe),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTimeframe = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Timeframe',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Total Earnings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '\$2,450.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'From 85 deliveries',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildEarningCard('Completed', '78', Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildEarningCard('Pending', '7', Colors.orange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child:
                      _buildEarningCard('Avg. Order', '\$28.82', Colors.purple),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildEarningCard('Cancelled', '5', Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.local_gas_station,
                        color: Colors.orange),
                    title: Text('Order #${1000 + index}'),
                    subtitle: const Text('13kg Cylinder'),
                    trailing: const Text(
                      '\$30.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
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

  Widget _buildEarningCard(String title, String value, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
