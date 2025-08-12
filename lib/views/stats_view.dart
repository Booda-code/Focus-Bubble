import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/daily_stats_model.dart';
import '../styles/app_colors.dart';
import '../widgets/stat_card.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  Map<String, int> weeklyMinutes = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };

  int totalSessions = 0;
  int totalMinutes = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final box = await Hive.openBox<DailyStatsModel>('dailyStats');
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));

    Map<String, int> tempMap = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };

    int sessions = 0;
    int minutes = 0;

    for (var stat in box.values) {
      final statDate = DateTime(stat.date.year, stat.date.month, stat.date.day);
      if (statDate.isAfter(startOfWeek.subtract(const Duration(seconds: 1)))) {
        final weekday = statDate.weekday;
        final day = _getDayName(weekday);
        tempMap[day] = tempMap[day]! + stat.totalFocusTimeInMinutes;
        sessions += stat.sessionsCount;
        minutes += stat.totalFocusTimeInMinutes;
      }
    }

    setState(() {
      weeklyMinutes = tempMap;
      totalSessions = sessions;
      totalMinutes = minutes;
    });
  }


  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
      default:
        return 'Sun';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
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
                StatCard(label: "Sessions", value: "$totalSessions"),
                StatCard(
                  label: "Focus Time",
                  value:
                  "${(totalMinutes ~/ 60)}h ${(totalMinutes % 60)}m",
                ),
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
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: weeklyMinutes.values.fold(
                    0,
                        (prev, next) => prev > next ? prev : next,
                  ).toDouble() +
                      10,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final dayIndex = value.toInt();
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          if (dayIndex < 0 || dayIndex > 6) return Container();
                          return Text(
                            days[dayIndex],
                            style: const TextStyle(color: Colors.black),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(7, (index) {
                    final day = _getDayName(index + 1);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (weeklyMinutes[day] ?? 0).toDouble(),
                          width: 16,
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Keep it up! 💪",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
