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
    return SafeArea(
      child: Column(
        children: [
          // Map View (fills available space)
          Expanded(
            child: Container(
              width: double.infinity,
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
          ),

          // Bottom section (location, history, button)
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              hintText: "Where to?",
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

                // History Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B2D42),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.history, color: Color(0xFF8D99AE)),
                        title: Text("Order #1234 - Delivered"),
                        subtitle: Text("13kg LPG Gas Cylinder"),
                        trailing: Text("\$30"),
                      ),
                      ListTile(
                        leading: Icon(Icons.history, color: Color(0xFF8D99AE)),
                        title: Text("Order #1233 - Cancelled"),
                        subtitle: Text("6kg LPG Gas Cylinder"),
                        trailing: Text("\$15"),
                      ),
                    ],
                  ),
                ),

                // Request Delivery Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: CustomButton(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
