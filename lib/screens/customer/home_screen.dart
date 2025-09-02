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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  double _sheetExtent = 0.25;
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  void _toggleSheet() {
    if (_sheetExtent > 0.25) {
      _sheetController.animateTo(
        0.25,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _sheetController.animateTo(
        0.85,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map background
        Container(
          width: double.infinity,
          height: double.infinity,
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

        // Hamburger icon (top right, always visible)
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.menu, color: Color(0xFF2B2D42)),
            padding: const EdgeInsets.all(10),
          ),
        ),

        // Map icon (top left, only when sheet is expanded)
        if (_sheetExtent > 0.25)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: _toggleSheet,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.map, color: Color(0xFF8D99AE)),
                padding: const EdgeInsets.all(10),
              ),
            ),
          ),

        // Draggable bottom sheet
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              _sheetExtent = notification.extent;
            });
            return true;
          },
          child: DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.25,
            minChildSize: 0.25,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                        // Where to (floating)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Services Offered (card)
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Services Offered",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2B2D42),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.local_gas_station, color: Color(0xFFFF6B35)),
                                          const SizedBox(height: 4),
                                          Text("LPG Delivery", textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.build, color: Color(0xFF8D99AE)),
                                          const SizedBox(height: 4),
                                          Text("Regulator & Hose", textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.support_agent, color: Color(0xFF2B2D42)),
                                          const SizedBox(height: 4),
                                          Text("Support", textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // History Section
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
                        const SizedBox(height: 80), // Space for button
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Request Delivery Button (always visible)
        Positioned(
          left: 16,
          right: 16,
          bottom: 24,
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
    );
  }
}
