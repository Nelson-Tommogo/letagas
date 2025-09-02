import 'package:flutter/material.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({super.key});

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

  // Profile data
  final Map<String, dynamic> _vendorData = {
    'name': 'GasPro Nairobi',
    'email': 'vendor@gaspro.com',
    'phone': '+254 712 345 678',
    'address': '123 Gas Street, Industrial Area, Nairobi',
    'rating': 4.8,
    'totalOrders': 256,
    'joinDate': 'January 2023',
    'businessLicense': 'GAS-7890-2023',
  };

  bool _notificationsEnabled = true;
  bool _emailUpdates = true;
  bool _smsUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text('Vendor Profile'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Business Information
            _buildSectionTitle('Business Information'),
            _buildInfoCard(),
            const SizedBox(height: 20),

            // Statistics
            _buildSectionTitle('Business Statistics'),
            _buildStatisticsRow(),
            const SizedBox(height: 20),

            // Settings
            _buildSectionTitle('Settings'),
            _buildSettingsCard(),
            const SizedBox(height: 20),

            // Actions
            _buildSectionTitle('Account Actions'),
            _buildActionButtons(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.1),
              border: Border.all(
                color: primaryColor,
                width: 3,
              ),
            ),
            child: Icon(
              Icons.store,
              size: 50,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Vendor Name
          Text(
            _vendorData['name'],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 8),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: accentColor, size: 20),
              const SizedBox(width: 4),
              Text(
                _vendorData['rating'].toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: secondaryColor,
                ),
              ),
              Text(
                ' (${_vendorData['totalOrders']} orders)',
                style: TextStyle(
                  color: secondaryColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Join Date
          Text(
            'Member since ${_vendorData['joinDate']}',
            style: TextStyle(
              color: secondaryColor.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.email, 'Email', _vendorData['email']),
          const Divider(),
          _buildInfoRow(Icons.phone, 'Phone', _vendorData['phone']),
          const Divider(),
          _buildInfoRow(Icons.location_on, 'Address', _vendorData['address']),
          const Divider(),
          _buildInfoRow(
              Icons.assignment, 'License', _vendorData['businessLicense']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Total Orders',
              _vendorData['totalOrders'].toString(), Icons.shopping_cart),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
              'Rating', _vendorData['rating'].toString(), Icons.star),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Months', '12', Icons.calendar_today),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: secondaryColor.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSwitchRow(
            Icons.notifications,
            'Push Notifications',
            _notificationsEnabled,
            (value) => setState(() => _notificationsEnabled = value),
          ),
          const Divider(),
          _buildSwitchRow(
            Icons.email,
            'Email Updates',
            _emailUpdates,
            (value) => setState(() => _emailUpdates = value),
          ),
          const Divider(),
          _buildSwitchRow(
            Icons.sms,
            'SMS Updates',
            _smsUpdates,
            (value) => setState(() => _smsUpdates = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
      IconData icon, String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: secondaryColor,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(
          'Edit Profile Information',
          Icons.edit,
          primaryColor,
          () {
            // Edit profile action
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'Change Password',
          Icons.lock,
          Colors.blue,
          () {
            // Change password action
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'Business Documents',
          Icons.description,
          Colors.purple,
          () {
            // Documents action
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'Logout',
          Icons.logout,
          Colors.red,
          () {
            // Logout action
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: color.withOpacity(0.3)),
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 16, color: color.withOpacity(0.6)),
        ],
      ),
    );
  }
}
