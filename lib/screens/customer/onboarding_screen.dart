import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Quick Gas Delivery',
      'description':
          'Get your gas cylinders delivered to your doorstep within minutes, anytime you need it',
      'image': 'assets/images/quickdelivery.jpg',
    },
    {
      'title': 'Track Your Order',
      'description':
          'Real-time tracking of your gas delivery from our depot to your location',
      'image':
          'assets/images/trackorder.jpg', // Use trackorder.jpg for tracking screen
    },
    {
      'title': 'Safe & Secure',
      'description':
          'Our delivery personnel are trained professionals ensuring safe handling of your gas cylinders',
      'image':
          'assets/images/letagaslogo.png', // Use a different image for safety screen
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF8F9FA),
              ],
            ),
          ),
          child: Column(
            children: [
              // Show logo only on the first screen
              if (_currentPage == 0) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                  child: Image.asset(
                    'assets/images/letagaslogo.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],

              // Skip button - show on all screens
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF8D99AE),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image with decorative frame
                          Container(
                            height: 250,
                            margin: const EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                onboardingData[index]['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),

                          Text(
                            onboardingData[index]['title']!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B2D42),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              onboardingData[index]['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8D99AE),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Page indicators
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Color(0xFFFF6B35)
                            : Color(0xFF8D99AE).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Next/Get Started button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B35),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // Back button (not shown on first page)
              if (_currentPage > 0) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xFF8D99AE),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
