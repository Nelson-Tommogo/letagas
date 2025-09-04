import 'package:flutter/material.dart';
import '../auth/reset_password_screen.dart'; // <-- corrected import

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _locationServices = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: secondaryColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: Container(
        color: lightBackground,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // User Profile Section
            Container(
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+254 712 345 678',
                          style: TextStyle(
                            color: secondaryColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: primaryColor),
                    onPressed: () {
                      // Edit profile
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Notifications Section
            _buildSectionHeader('NOTIFICATIONS'),
            const SizedBox(height: 8),
            Container(
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
              child: Column(
                children: [
                  _buildSettingSwitch(
                    title: 'Push Notifications',
                    value: _notificationsEnabled,
                    icon: Icons.notifications,
                    onChanged: (value) =>
                        setState(() => _notificationsEnabled = value),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingSwitch(
                    title: 'Email Notifications',
                    value: _emailNotifications,
                    icon: Icons.email,
                    onChanged: (value) =>
                        setState(() => _emailNotifications = value),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingSwitch(
                    title: 'SMS Notifications',
                    value: _smsNotifications,
                    icon: Icons.sms,
                    onChanged: (value) =>
                        setState(() => _smsNotifications = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Privacy & Security Section
            _buildSectionHeader('PRIVACY & SECURITY'),
            const SizedBox(height: 8),
            Container(
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
              child: Column(
                children: [
                  _buildSettingSwitch(
                    title: 'Location Services',
                    value: _locationServices,
                    icon: Icons.location_on,
                    onChanged: (value) =>
                        setState(() => _locationServices = value),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'Change Password',
                    icon: Icons.lock,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'Privacy Policy',
                    icon: Icons.privacy_tip,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'Terms of Service',
                    icon: Icons.description,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // App Settings Section
            _buildSectionHeader('APP SETTINGS'),
            const SizedBox(height: 8),
            Container(
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
              child: Column(
                children: [
                  _buildSettingItem(
                    title: 'Language',
                    subtitle: 'English',
                    icon: Icons.language,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingSwitch(
                    title: 'Dark Mode',
                    value: _darkMode,
                    icon: Icons.dark_mode,
                    onChanged: (value) => setState(() => _darkMode = value),
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'App Version',
                    subtitle: '1.0.0',
                    icon: Icons.info,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Support Section
            _buildSectionHeader('SUPPORT'),
            const SizedBox(height: 8),
            Container(
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
              child: Column(
                children: [
                  _buildSettingItem(
                    title: 'Help Center',
                    icon: Icons.help_center,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'Contact Support',
                    icon: Icons.support_agent,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 16),
                  _buildSettingItem(
                    title: 'Rate Our App',
                    icon: Icons.star,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Handle logout
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Log Out'),
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
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: secondaryColor.withOpacity(0.6),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required bool value,
    required IconData icon,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: secondaryColor,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: secondaryColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: secondaryColor.withOpacity(0.6),
              ),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: secondaryColor.withOpacity(0.3),
      ),
      onTap: onTap,
    );
  }
}
