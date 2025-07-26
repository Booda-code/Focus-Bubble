import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../widgets/setting_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            /// Notifications toggle
            const SettingTile(
              title: "Notifications",
              trailing: Switch(value: true, onChanged: null),
            ),
            /// Dark Mode toggle
            const SettingTile(
              title: "Dark Mode",
              trailing: Switch(value: false, onChanged: null),
            ),
            /// Daily Goal
            const SettingTile(
              title: "Daily Focus Goal",
              trailing: Text("60 min", style: TextStyle(fontSize: 16, color: Colors.black87)),
            ),
            const SizedBox(height: 16),
            /// About
            const SettingTile(
              title: "About",
              trailing: Icon(Icons.info_outline, color: Colors.black54),
            ),

            /// Logout
            const SettingTile(
              title: "Logout",
              trailing: Icon(Icons.logout, color: Colors.redAccent),
              titleColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
