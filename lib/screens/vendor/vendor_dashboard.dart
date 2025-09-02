import 'package:flutter/material.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard('Orders', '12', Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard('Delivered', '8', Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('Pending', '4', Colors.orange),
                const SizedBox(width: 16),
                _buildStatCard('Earnings', '\$240', Colors.purple),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Recent Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.local_gas_station,
                          color: Colors.orange),
                      title: Text('Order #${1000 + index}'),
                      subtitle: const Text('13kg Cylinder - \$30'),
                      trailing: Chip(
                        label: const Text(
                          'Pending',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: Colors.orange,
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

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
