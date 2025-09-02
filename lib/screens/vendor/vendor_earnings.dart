import 'package:flutter/material.dart';

class VendorEarnings extends StatefulWidget {
  const VendorEarnings({super.key});

  @override
  State<VendorEarnings> createState() => _VendorEarningsState();
}

class _VendorEarningsState extends State<VendorEarnings> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

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
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: lightBackground,
      body: Column(
        children: [
          // Timeframe selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  value: _selectedTimeframe,
                  items: _timeframes.map((timeframe) {
                    return DropdownMenuItem(
                      value: timeframe,
                      child: Text(
                        timeframe,
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTimeframe = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Timeframe',
                    labelStyle:
                        TextStyle(color: secondaryColor.withOpacity(0.7)),
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                  dropdownColor: Colors.white,
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Total Earnings Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Total Earnings',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '\$2,450.00',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_shipping,
                            color: accentColor, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'From 85 deliveries',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Stats Cards - First Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildEarningCard('Completed', '78',
                      primaryColor.withOpacity(0.9), Icons.check_circle),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEarningCard(
                      'Pending', '7', Colors.orange[700]!, Icons.access_time),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Stats Cards - Second Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildEarningCard('Avg. Order', '\$28.82',
                      Colors.purple[700]!, Icons.attach_money),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEarningCard(
                      'Cancelled', '5', Colors.red[700]!, Icons.cancel),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent Transactions Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
                const Spacer(),
                Text(
                  'View All',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: index < 9
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.local_gas_station,
                            color: primaryColor, size: 20),
                      ),
                      title: Text(
                        'Order #${1000 + index}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: secondaryColor,
                        ),
                      ),
                      subtitle: Text(
                        '13kg Cylinder • ${index + 1}h ago',
                        style: TextStyle(
                          color: secondaryColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        '\$30.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                          fontSize: 16,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEarningCard(
      String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: secondaryColor.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: secondaryColor,
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
