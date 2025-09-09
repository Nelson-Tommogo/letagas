import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/bottom_nav.dart';
import '../../widgets/custom_button.dart';
import 'info/profile_screen.dart';
import 'order_request_screen.dart';
import 'order_tracking_screen.dart';

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
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  final TextEditingController _addressController = TextEditingController();
  List<String> _searchHistory = [];
  final FocusNode _addressFocusNode = FocusNode();
  GoogleMapController? _mapController;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-1.286389, 36.817223), // Nairobi CBD
    zoom: 13,
  );

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    _addressFocusNode.addListener(() {
      if (_addressFocusNode.hasFocus && _sheetExtent < 0.5) {
        _sheetController.animateTo(
          0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  void _loadSearchHistory() async {
    // Simulate loading from local storage
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _searchHistory = [
        "123 Main Street, Nairobi",
        "456 Westlands, Nairobi",
        "789 Kilimani, Nairobi",
        "321 Karen, Nairobi"
      ];
    });
  }

  void _saveSearchHistory(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      // Remove if already exists to avoid duplicates
      _searchHistory
          .removeWhere((item) => item.toLowerCase() == query.toLowerCase());

      // Add to beginning of list
      _searchHistory.insert(0, query);

      // Keep only last 4 searches
      if (_searchHistory.length > 4) {
        _searchHistory = _searchHistory.sublist(0, 4);
      }
    });

    // Save to local storage (simulated)
    // SharedPreferences.getInstance().then((prefs) {
    //   prefs.setStringList('searchHistory', _searchHistory);
    // });
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
    // Clear from local storage (simulated)
    // SharedPreferences.getInstance().then((prefs) {
    //   prefs.remove('searchHistory');
    // });
  }

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

  void _navigateToExpressDelivery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderRequestScreen(
          deliveryType: 'Express',
          extraCharges: 200, // Ksh 200 extra for express delivery
          deliveryTime: '5-10 minutes',
        ),
      ),
    );
  }

  void _navigateToNormalDelivery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderRequestScreen(
          deliveryType: 'Normal',
          extraCharges: 0, // No extra charges for normal delivery
          deliveryTime: '30 minutes',
        ),
      ),
    );
  }

  void _navigateToSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Support'),
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: Colors.white,
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Support',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.phone, color: Color(0xFFFF6B35)),
                  title: Text('Call Us'),
                  subtitle: Text('+254 700 123 456'),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Color(0xFFFF6B35)),
                  title: Text('Email Us'),
                  subtitle: Text('support@letagas.com'),
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Color(0xFFFF6B35)),
                  title: Text('Live Chat'),
                  subtitle: Text('Available 24/7'),
                ),
                ListTile(
                  leading: Icon(Icons.help, color: Color(0xFFFF6B35)),
                  title: Text('FAQs'),
                  subtitle: Text('Frequently Asked Questions'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map background
        SizedBox.expand(
          child: GoogleMap(
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
        ),

        // Hamburger icon (top right, now functional)
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: PopupMenuButton<String>(
            icon: Container(
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
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              } else if (value == 'orders') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderTrackingScreen()),
                );
              } else if (value == 'support') {
                _navigateToSupport();
              } else if (value == 'logout') {
                // Add your logout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ),
              const PopupMenuItem(
                value: 'orders',
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Order History'),
                ),
              ),
              const PopupMenuItem(
                value: 'support',
                child: ListTile(
                  leading: Icon(Icons.support_agent),
                  title: Text('Support'),
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
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
                              Expanded(
                                child: TextField(
                                  controller: _addressController,
                                  focusNode: _addressFocusNode,
                                  decoration: InputDecoration(
                                    hintText: "Delivery Address?",
                                    border: InputBorder.none,
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF8D99AE)),
                                    suffixIcon:
                                        _addressController.text.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.clear,
                                                    size: 20),
                                                onPressed: () {
                                                  _addressController.clear();
                                                  setState(() {});
                                                },
                                              )
                                            : null,
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xFF2B2D42),
                                  ),
                                  onSubmitted: (value) {
                                    _saveSearchHistory(value);
                                    _addressFocusNode.unfocus();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.search,
                                    color: Color(0xFFFF6B35)),
                                onPressed: () {
                                  if (_addressController.text.isNotEmpty) {
                                    _saveSearchHistory(_addressController.text);
                                    _addressFocusNode.unfocus();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        // Show search history when text field is focused or has text
                        if (_addressFocusNode.hasFocus &&
                            _searchHistory.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Recent Searches",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2B2D42),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _clearSearchHistory,
                                    child: const Text(
                                      "Clear",
                                      style:
                                          TextStyle(color: Color(0xFFFF6B35)),
                                    ),
                                  ),
                                ],
                              ),
                              ..._searchHistory
                                  .map((address) => ListTile(
                                        leading: const Icon(Icons.history,
                                            size: 20, color: Color(0xFF8D99AE)),
                                        title: Text(address),
                                        onTap: () {
                                          _addressController.text = address;
                                          _addressFocusNode.unfocus();
                                        },
                                        contentPadding: EdgeInsets.zero,
                                      ))
                                  .toList(),
                            ],
                          ),

                        const SizedBox(height: 20),

                        // Services Offered (card)
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Services Offered",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2B2D42),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Express Delivery
                                    Expanded(
                                      child: InkWell(
                                        onTap: _navigateToExpressDelivery,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF6B35)
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.flash_on,
                                                  color: Color(0xFFFF6B35),
                                                  size: 24),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Express\nDelivery",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "5-10 mins",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[600]),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "+Ksh 200",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      const Color(0xFFFF6B35),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Normal Delivery
                                    Expanded(
                                      child: InkWell(
                                        onTap: _navigateToNormalDelivery,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF2B2D42)
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.timer,
                                                  color: Color(0xFF2B2D42),
                                                  size: 24),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Normal\nDelivery",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "30 mins",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[600]),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "No extra fee",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Support
                                    Expanded(
                                      child: InkWell(
                                        onTap: _navigateToSupport,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF8D99AE)
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                  Icons.support_agent,
                                                  color: Color(0xFF8D99AE),
                                                  size: 24),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Support",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "24/7 Help",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
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
                        const Text(
                          "Recent Orders",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B2D42),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.local_gas_station,
                              color: Color(0xFFFF6B35)),
                          title: const Text("Order #1234 - Delivered"),
                          subtitle:
                              const Text("13kg LPG Gas Cylinder - Westlands"),
                          trailing: const Text("Ksh 3,000"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.local_gas_station,
                              color: Color(0xFFFF6B35)),
                          title: const Text("Order #1233 - Cancelled"),
                          subtitle:
                              const Text("6kg LPG Gas Cylinder - Kilimani"),
                          trailing: const Text("Ksh 1,500"),
                          onTap: () {},
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

  @override
  void dispose() {
    _addressController.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }
}
