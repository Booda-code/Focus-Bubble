import 'package:hive/hive.dart';

part 'daily_stats_model.g.dart';

@HiveType(typeId: 1)
class DailyStatsModel extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int totalFocusTimeInMinutes;

  @HiveField(2)
  int sessionsCount;

  DailyStatsModel({
    required this.date,
    required this.totalFocusTimeInMinutes,
    required this.sessionsCount,
  });
}

