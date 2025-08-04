import 'package:hive/hive.dart';

part 'app_settings_model.g.dart';

@HiveType(typeId: 2)
class AppSettingsModel extends HiveObject {
  @HiveField(0)
  final int defaultSessionDuration;
  @HiveField(1)
  final bool isNotificationEnabled;
  @HiveField(2)
  final bool soundEnabled;

  AppSettingsModel({
    required this.defaultSessionDuration,
    required this.isNotificationEnabled,
    required this.soundEnabled,
  });
}
