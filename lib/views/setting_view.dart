import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/theme_cubit.dart';
import '../styles/app_colors.dart';
import '../widgets/setting_tile.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notificationsMuted = false;

  Future<void> _toggleNotifications(bool value) async {
    print("🔄 Toggle Switch to: $value");

    try {
      final bool? isGranted =
          await FlutterDnd.isNotificationPolicyAccessGranted;
      print("🛂 Permission granted: $isGranted");

      if (value) {
        if (isGranted != true) {
          print("❌ Permission not granted. Redirecting to settings...");
          FlutterDnd.gotoPolicySettings();
          return; // نخرج ومش بنفذ setState هنا
        }

        await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_NONE,
        );
      } else {
        await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_ALL,
        );
      }

      // نفذ setState فقط لو كل حاجة مشت صح
      setState(() {
        _notificationsMuted = value;
      });

      print("✅ Notification muted set to: $_notificationsMuted");
    } catch (e) {
      print("❌ Error during toggle: $e");
    }
  }

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
            SettingTile(
              title: "Notifications",
              trailing: Switch(
                value: _notificationsMuted,
                onChanged: _toggleNotifications,
              ),
            ),

            SettingTile(
              title: "Dark Mode",
              trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isDark = themeMode == ThemeMode.dark;
                  return Switch(
                    value: isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                  );
                },
              ),
            ),

            /// Daily Goal
            const SettingTile(
              title: "Daily Focus Goal",
              trailing: Text(
                "60 min",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),

            /// About
            const SettingTile(
              title: "About",
              trailing: Icon(Icons.info_outline, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
