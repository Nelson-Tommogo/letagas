import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'card',
      'last4': '4242',
      'brand': 'Visa',
      'isDefault': true,
      'expiry': '12/25',
    },
    {
      'type': 'card',
      'last4': '8888',
      'brand': 'Mastercard',
      'isDefault': false,
      'expiry': '08/24',
    },
    {
      'type': 'mobile',
      'provider': 'M-Pesa',
      'phone': '+254 712 345 678',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.white,
        foregroundColor: secondaryColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: Container(
        color: lightBackground,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _paymentMethods.length + 1, // +1 for the header
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Your payment methods',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: secondaryColor,
                  ),
                ),
              );
            }

            final methodIndex = index - 1;
            final method = _paymentMethods[methodIndex];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    method['type'] == 'card'
                        ? Icons.credit_card
                        : Icons.phone_android,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                title: method['type'] == 'card'
                    ? RichText(
                        text: TextSpan(
                          text: '${method['brand']} ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: secondaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: '•••• ${method['last4']}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: secondaryColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        method['provider'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                subtitle: method['type'] == 'mobile'
                    ? Text(
                        method['phone'],
                        style: TextStyle(
                          color: secondaryColor.withOpacity(0.6),
                        ),
                      )
                    : Text(
                        'Expires ${method['expiry']}',
                        style: TextStyle(
                          color: secondaryColor.withOpacity(0.6),
                        ),
                      ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (method['isDefault'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: secondaryColor.withOpacity(0.5),
                      ),
                      onPressed: () => _showOptions(methodIndex),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPaymentMethod,
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showOptions(int index) {
    final method = _paymentMethods[index];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!method['isDefault'])
              ListTile(
                leading: Icon(Icons.star, color: accentColor),
                title: const Text('Set as default'),
                onTap: () {
                  Navigator.pop(context);
                  _setDefaultMethod(index);
                },
              ),
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: const Text('Edit details'),
              onTap: () {
                Navigator.pop(context);
                method['type'] == 'card'
                    ? _showEditCardDialog(index)
                    : _showEditMobileDialog(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove'),
              onTap: () {
                Navigator.pop(context);
                _removeMethod(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setDefaultMethod(int index) {
    setState(() {
      for (var method in _paymentMethods) {
        method['isDefault'] = false;
      }
      _paymentMethods[index]['isDefault'] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_paymentMethods[index]['type'] == 'card' ? 'Card' : _paymentMethods[index]['provider']} set as default',
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  void _removeMethod(int index) {
    final method = _paymentMethods[index];
    final isDefault = method['isDefault'];

    setState(() {
      _paymentMethods.removeAt(index);
      // If we removed the default, set the first method as default
      if (isDefault && _paymentMethods.isNotEmpty) {
        _paymentMethods[0]['isDefault'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${method['type'] == 'card' ? 'Card' : method['provider']} removed',
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Text(
              'Add payment method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.credit_card, color: primaryColor),
              ),
              title: Text(
                'Credit/Debit Card',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: secondaryColor.withOpacity(0.3), size: 16),
              onTap: () {
                Navigator.pop(context);
                _showAddCardDialog();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.phone_android, color: primaryColor),
              ),
              title: Text(
                'Mobile Money',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: secondaryColor.withOpacity(0.3), size: 16),
              onTap: () {
                Navigator.pop(context);
                _showAddMobileDialog();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showAddCardDialog() {
    // Implement card addition dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Card',
          style: TextStyle(color: secondaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                labelStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      labelStyle:
                          TextStyle(color: secondaryColor.withOpacity(0.6)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      labelStyle:
                          TextStyle(color: secondaryColor.withOpacity(0.6)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: secondaryColor.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add card logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Card added successfully'),
                  backgroundColor: primaryColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child:
                const Text('Add Card', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditCardDialog(int index) {
    // Similar to add card but with pre-filled data
  }

  void _showAddMobileDialog() {
    // Implement mobile money addition dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Mobile Money',
          style: TextStyle(color: secondaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Provider',
                labelStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              items: ['M-Pesa', 'Airtel Money', 'T-Kash', 'Other']
                  .map((provider) => DropdownMenuItem(
                        value: provider,
                        child: Text(provider),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: secondaryColor.withOpacity(0.6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add mobile money logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Mobile money added successfully'),
                  backgroundColor: primaryColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditMobileDialog(int index) {
    // Similar to add mobile but with pre-filled data
  }
}
