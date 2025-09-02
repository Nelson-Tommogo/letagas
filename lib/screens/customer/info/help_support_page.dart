import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSupportExpansion(
            Icons.help_outline,
            'FAQs',
            'Frequently asked questions',
            [
              'How do I place an order?',
              'How do I track my delivery?',
              'What payment methods are accepted?',
            ],
          ),
          _buildSupportExpansion(
            Icons.contact_support,
            'Contact Support',
            'Get in touch with our support team',
            [
              'Phone: +254 700 123 456',
              'Email: support@gasapp.com',
              'Available 24/7',
            ],
          ),
          _buildSupportExpansion(
            Icons.description,
            'Terms of Service',
            'Read our terms and conditions',
            [
              'View our terms and conditions on our website.',
            ],
          ),
          _buildSupportExpansion(
            Icons.security,
            'Privacy Policy',
            'Learn about our privacy practices',
            [
              'Your data is protected and handled securely.',
            ],
          ),
          _buildSupportExpansion(
            Icons.feedback,
            'Send Feedback',
            'Share your experience with us',
            [
              'We value your feedback! Email us at feedback@gasapp.com.',
            ],
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Contact',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Customer Support: +254 700 123 456'),
                  SizedBox(height: 4),
                  Text('Email: support@gasapp.com'),
                  SizedBox(height: 4),
                  Text('Available 24/7'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportExpansion(
    IconData icon,
    String title,
    String subtitle,
    List<String> details,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(icon, color: const Color(0xFFF05E23)),
        title: Text(title),
        subtitle: Text(subtitle),
        children: details
            .map((detail) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(detail),
                ))
            .toList(),
      ),
    );
  }
}
