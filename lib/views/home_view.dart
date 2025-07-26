import 'package:flutter/material.dart';
import 'package:focus_bubble/styles/app_colors.dart';
import 'package:focus_bubble/views/stats_view.dart';

import '../widgets/custom_buttom.dart';
import 'focus_session_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            'Focus Bubble',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
                fontFamily: 'Poppins'
            ),
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
              IconButton(onPressed: () {}, icon: Icon(Icons.settings, size: 32)),
            ],
          ),
        ],
      ),
    );
  }
}

