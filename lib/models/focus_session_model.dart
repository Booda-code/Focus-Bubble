import 'package:hive/hive.dart';

part 'focus_session_model.g.dart';
@HiveType(typeId: 0)

class FocusSessionModel extends HiveObject {
  @HiveField(0)
  final DateTime startTime;

  @HiveField(1)
  final DateTime endTime;

  @HiveField(2)
  final int durationMinutes;

  @HiveField(3)
  final bool isCompleted;

  FocusSessionModel({
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.isCompleted,
  });
}
