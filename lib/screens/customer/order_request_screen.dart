import 'package:flutter/material.dart';

class OrderRequestScreen extends StatefulWidget {
  const OrderRequestScreen({super.key});

  @override
  State<OrderRequestScreen> createState() => _OrderRequestScreenState();
}

class _OrderRequestScreenState extends State<OrderRequestScreen> {
  String _selectedCylinderSize = '13kg';
  String _selectedPaymentMethod = 'Cash on Delivery';
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  bool _isSubmitting = false;

  // Brand colors
  final Color _primaryColor = const Color(0xFFFF6B35); // Primary brand color
  final Color _secondaryColor = const Color(0xFF2E3192); // Secondary from logo
  final Color _backgroundColor = const Color(0xFFF8FAFC);
  final Color _textColor = const Color(0xFF1E293B);
  final Color _hintColor = const Color(0xFF64748B);
  final Color _successColor = const Color(0xFF4CAF50);

  final List<String> cylinderSizes = ['6kg', '13kg', '22kg', '50kg'];
  final List<String> paymentMethods = [
    'Cash on Delivery',
    'Mobile Money',
    'Credit Card'
  ];

  // Pricing information
  final Map<String, double> cylinderPrices = {
    '6kg': 15.0,
    '13kg': 25.0,
    '22kg': 40.0,
    '50kg': 80.0,
  };
  final double deliveryFee = 5.0;

  double get totalCost =>
      (cylinderPrices[_selectedCylinderSize] ?? 0) + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Request Gas Delivery'),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.local_gas_station,
                    size: 50,
                    color: _primaryColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gas Delivery Request',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _textColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Fill in the details below to place your order',
                    style: TextStyle(
                      fontSize: 14,
                      color: _hintColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Cylinder Size Selection
            _buildSectionHeader('Cylinder Size'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCylinderSize,
                items: cylinderSizes.map((size) {
                  return DropdownMenuItem(
                    value: size,
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 16,
                        color: _textColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCylinderSize = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
                dropdownColor: Colors.white,
                style: TextStyle(color: _textColor, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // Delivery Address
            _buildSectionHeader('Delivery Address'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter your complete delivery address',
                  hintStyle: TextStyle(color: _hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Special Instructions
            _buildSectionHeader('Special Instructions (Optional)'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _instructionsController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Any special instructions for the delivery person',
                  hintStyle: TextStyle(color: _hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Payment Method
            _buildSectionHeader('Payment Method'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: paymentMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(
                      method,
                      style: TextStyle(
                        fontSize: 16,
                        color: _textColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
                dropdownColor: Colors.white,
                style: TextStyle(color: _textColor, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSectionHeader('Order Summary'),
                  const SizedBox(height: 15),
                  _buildCostRow('Gas Cost (${_selectedCylinderSize})',
                      '\$${cylinderPrices[_selectedCylinderSize]?.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  _buildCostRow(
                      'Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
                  const SizedBox(height: 15),
                  const Divider(height: 1),
                  const SizedBox(height: 15),
                  _buildCostRow('Total:', '\$${totalCost.toStringAsFixed(2)}',
                      isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Place Order Button
            _isSubmitting
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        if (_addressController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Please enter your delivery address'),
                              backgroundColor: Colors.red[400],
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _isSubmitting = true;
                        });

                        // Simulate order submission
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _isSubmitting = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Order placed successfully!'),
                              backgroundColor: _successColor,
                            ),
                          );
                          Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        'PLACE ORDER',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _textColor,
      ),
    );
  }

  Widget _buildCostRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? _primaryColor : _textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isTotal ? _primaryColor : _textColor,
          ),
        ),
      ],
    );
  }
}
