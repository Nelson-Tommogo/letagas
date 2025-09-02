import 'package:flutter/material.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand colors
    final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
    final Color secondaryColor = const Color(0xFF333333); // Dark gray
    final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
    final Color lightBackground = const Color(0xFFF8F9FA); // Light background

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: lightBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStatCard('Orders', '12', primaryColor,
                      Icons.shopping_cart_outlined),
                  const SizedBox(width: 16),
                  _buildStatCard('Delivered', '8', const Color(0xFF4CAF50),
                      Icons.check_circle_outlined),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard('Pending', '4', const Color(0xFFFF9800),
                      Icons.pending_actions_outlined),
                  const SizedBox(width: 16),
                  _buildStatCard('Earnings', '\$240', const Color(0xFF9C27B0),
                      Icons.attach_money_outlined),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // Vary status for demonstration
                    final statuses = [
                      'Pending',
                      'Processing',
                      'Delivered',
                      'Cancelled'
                    ];
                    final statusColors = [
                      const Color(0xFFFF9800),
                      primaryColor,
                      const Color(0xFF4CAF50),
                      const Color(0xFFF44336)
                    ];
                    final statusIndex = index % statuses.length;

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.local_gas_station,
                              color: primaryColor),
                        ),
                        title: Text(
                          'Order #${1000 + index}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                        ),
                        subtitle: Text(
                          '13kg Cylinder - \$30',
                          style: TextStyle(
                            color: secondaryColor.withOpacity(0.6),
                          ),
                        ),
                        trailing: Chip(
                          label: Text(
                            statuses[statusIndex],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: statusColors[statusIndex],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.8), color],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(height: 10),
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
