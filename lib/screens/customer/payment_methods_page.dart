import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'card',
      'last4': '4242',
      'brand': 'Visa',
      'isDefault': true,
    },
    {
      'type': 'card',
      'last4': '8888',
      'brand': 'Mastercard',
      'isDefault': false,
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          final method = _paymentMethods[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(
                method['type'] == 'card'
                    ? Icons.credit_card
                    : Icons.phone_android,
                color: const Color(0xFFF05E23),
              ),
              title: method['type'] == 'card'
                  ? Text('${method['brand']} •••• ${method['last4']}')
                  : Text('${method['provider']}'),
              subtitle:
                  method['type'] == 'mobile' ? Text(method['phone']) : null,
              trailing: method['isDefault']
                  ? const Chip(
                      label: Text('Default', style: TextStyle(fontSize: 12)),
                      backgroundColor: Color(0xFFF05E23),
                      labelStyle: TextStyle(color: Colors.white),
                    )
                  : null,
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPaymentMethod,
        backgroundColor: const Color(0xFFF05E23),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.credit_card, color: Color(0xFFF05E23)),
              title: const Text('Add Credit/Debit Card'),
              onTap: () {
                Navigator.pop(context);
                _showAddCardDialog();
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.phone_android, color: Color(0xFFF05E23)),
              title: const Text('Add Mobile Money'),
              onTap: () {
                Navigator.pop(context);
                _showAddMobileDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCardDialog() {
    // Implement card addition dialog
  }

  void _showAddMobileDialog() {
    // Implement mobile money addition dialog
  }
}
