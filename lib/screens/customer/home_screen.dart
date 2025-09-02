import 'package:flutter/material.dart';

import '../../widgets/bottom_nav.dart';
import '../../widgets/custom_button.dart';
import 'order_request_screen.dart';
import 'order_tracking_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const OrderTrackingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map View (Placeholder)
        Container(
          color: const Color(0xFFF8F9FA),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map, size: 100, color: Color(0xFF8D99AE)),
                const SizedBox(height: 10),
                Text(
                  "Map View",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF8D99AE),
                  ),
                ),
              ],
            ),
          ),
        ),

        // App Bar
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF6B35),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter delivery address",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xFF8D99AE)),
                    ),
                    style: TextStyle(
                      color: Color(0xFF2B2D42),
                    ),
                  ),
                ),
                Icon(Icons.menu, color: Color(0xFF2B2D42)),
              ],
            ),
          ),
        ),

        // Bottom Request Panel
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Request Gas Delivery",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B2D42),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.local_gas_station, color: Color(0xFFFF6B35)),
                    const SizedBox(width: 10),
                    Text(
                      "13kg LPG Gas Cylinder",
                      style: TextStyle(
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$25",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.delivery_dining, color: Color(0xFF2B2D42)),
                    const SizedBox(width: 10),
                    Text(
                      "Delivery Fee",
                      style: TextStyle(
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$5",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20, color: Color(0xFF8D99AE)),
                Row(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$30",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: "REQUEST DELIVERY",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderRequestScreen()),
                    );
                  },
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
