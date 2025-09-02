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
          _buildSupportOption(
            context,
            Icons.help_outline,
            'FAQs',
            'Frequently asked questions',
            () {},
          ),
          _buildSupportOption(
            context,
            Icons.contact_support,
            'Contact Support',
            'Get in touch with our support team',
            () {},
          ),
          _buildSupportOption(
            context,
            Icons.description,
            'Terms of Service',
            'Read our terms and conditions',
            () {},
          ),
          _buildSupportOption(
            context,
            Icons.security,
            'Privacy Policy',
            'Learn about our privacy practices',
            () {},
          ),
          _buildSupportOption(
            context,
            Icons.feedback,
            'Send Feedback',
            'Share your experience with us',
            () {},
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

  Widget _buildSupportOption(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFF05E23)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
