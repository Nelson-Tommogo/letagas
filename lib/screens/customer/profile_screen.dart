import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildProfileOption(Icons.person, 'Personal Information'),
            _buildProfileOption(Icons.location_on, 'Delivery Addresses'),
            _buildProfileOption(Icons.payment, 'Payment Methods'),
            _buildProfileOption(Icons.history, 'Order History'),
            _buildProfileOption(Icons.settings, 'Settings'),
            _buildProfileOption(Icons.help, 'Help & Support'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Logout logic
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
