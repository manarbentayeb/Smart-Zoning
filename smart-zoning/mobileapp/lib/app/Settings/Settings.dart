import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildSectionHeader('Compte'),
            _buildSettingItem(
              icon: Icons.person,
              title: 'Profil',
              onTap: () {
                // Navigate to profile settings
              },
            ),
            _buildSettingItem(
              icon: Icons.email,
              title: 'Email',
              onTap: () {
                // Navigate to email settings
              },
            ),
            _buildSettingItem(
              icon: Icons.lock,
              title: 'Mot de passe',
              onTap: () {
                // Navigate to password settings
              },
            ),
            const Divider(height: 40),
            _buildSectionHeader('Application'),
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // Navigate to notification settings
              },
            ),
            _buildSettingItem(
              icon: Icons.dark_mode,
              title: 'Mode sombre',
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Handle dark mode toggle
                },
              ),
            ),
            _buildSettingItem(
              icon: Icons.language,
              title: 'Langue',
              trailing: const Text('Français'),
              onTap: () {
                // Navigate to language settings
              },
            ),
            const Divider(height: 40),
            _buildSectionHeader('Aide'),
            _buildSettingItem(
              icon: Icons.help,
              title: 'Aide & Support',
              onTap: () {
                // Navigate to help page
              },
            ),
            _buildSettingItem(
              icon: Icons.info,
              title: 'À propos',
              onTap: () {
                // Navigate to about page
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
}
