import 'package:flutter/material.dart';
import 'package:focus_bubble/styles/app_colors.dart';
import 'package:focus_bubble/views/setting_view.dart';
import 'package:focus_bubble/views/stats_view.dart';

import '../widgets/custom_buttom.dart';
import 'focus_session_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondaryColor.withOpacity(0.5),
                      width: 6,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'Focus Bubble',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                      fontFamily: 'Poppins'
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Text(
              'Ready to focus?',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 20,fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20),
            CustomBottom(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FocusSessionView()));
              },
              text: 'Start Session',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StatsView()));
                }, icon: Icon(Icons.bar_chart, size: 32)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
                }, icon: Icon(Icons.settings, size: 32)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
