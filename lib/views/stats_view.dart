import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/weekly_bar_chart.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor, // Mint
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Stats",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(label: "Sessions", value: "12"),
                StatCard(label: "Focus Time", value: "5h 20m"),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "This Week",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: WeeklyBarChart(),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Keep going!",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Widget لتوليد الأعمدة مع خيارات التخصيص
  BarChartGroupData _barGroup(int x, double toY, {bool isMax = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: toY,
          color: isMax ? Colors.greenAccent : Colors.white,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

}
