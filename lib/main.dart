import 'package:flutter/material.dart';
import 'package:focus_bubble/views/home_view.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/app_settings_model.dart';
import 'models/daily_stats_model.dart';
import 'models/focus_session_model.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(FocusSessionModelAdapter());
  Hive.registerAdapter(DailyStatsModelAdapter());
  Hive.registerAdapter(AppSettingsModelAdapter());

  runApp(const FocusBubble());
}

class FocusBubble extends StatelessWidget {
  const FocusBubble ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
