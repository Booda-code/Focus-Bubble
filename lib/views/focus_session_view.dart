import 'package:flutter/material.dart';
import 'package:focus_bubble/widgets/custom_buttom.dart';
import 'package:lottie/lottie.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:hive/hive.dart';
import '../models/focus_session_model.dart';
import '../models/daily_stats_model.dart';
import '../styles/app_colors.dart';

class FocusSessionView extends StatefulWidget {
  const FocusSessionView({super.key});

  @override
  State<FocusSessionView> createState() => _FocusSessionViewState();
}

class _FocusSessionViewState extends State<FocusSessionView> {
  late StopWatchTimer _stopWatchTimer;
  bool _isRunning = false;
  late int _initialTimeMs;
  int _selectedMinutes = 1;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    _initialTimeMs = _selectedMinutes * 60 * 1000;
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: _initialTimeMs,
      onEnded: _onTimerFinished,
    );
  }

  void _onTimerFinished() async {
    debugPrint('Countdown Ended');

    final box = await Hive.openBox<FocusSessionModel>('sessions');

    final now = DateTime.now();
    final session = FocusSessionModel(
      startTime: now.subtract(Duration(minutes: _selectedMinutes)),
      endTime: now,
      durationMinutes: _selectedMinutes,
      isCompleted: true,
    );

    await box.add(session);

    // ✅ حفظ إحصائيات اليوم
    await _saveDailyStats(_selectedMinutes);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Time's up!"),
        content: const Text("Great job staying focused 🎉"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  /// ✅ دالة لحفظ أو تحديث DailyStats
  Future<void> _saveDailyStats(int focusMinutes) async {
    final statsBox = await Hive.openBox<DailyStatsModel>('dailyStats');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (statsBox.containsKey(today)) {
      final current = statsBox.get(today);
      if (current != null) {
        current.totalFocusTimeInMinutes += focusMinutes;
        current.sessionsCount += 1;
        await current.save();
      }
    } else {
      await statsBox.put(
        today,
        DailyStatsModel(
          date: today,
          totalFocusTimeInMinutes: focusMinutes,
          sessionsCount: 1,
        ),
      );
    }
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _resetTimer() {
    _stopWatchTimer.onResetTimer();
    _stopWatchTimer.setPresetTime(mSec: _initialTimeMs);
    setState(() {
      _isRunning = false;
    });
  }

  void _startTimer() {
    _stopWatchTimer.onStartTimer();
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _stopWatchTimer.onStopTimer();
    setState(() {
      _isRunning = false;
    });
  }

  void _selectTimeDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [15, 25, 45].map((minute) {
          return ListTile(
            title: Text("$minute دقيقة"),
            onTap: () {
              setState(() {
                _selectedMinutes = minute;
                _initTimer();
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset(
                'assets/lottie/Green Flashing Circle Icon.json',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _initialTimeMs,
              builder: (context, snapshot) {
                final displayTime = StopWatchTimer.getDisplayTime(
                  snapshot.data ?? 0,
                  milliSecond: false,
                );
                return Text(
                  displayTime,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBottom(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  text: _isRunning ? 'Pause' : 'Start',
                  backgroundColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                CustomBottom(
                  onPressed: _resetTimer,
                  text: 'Reset',
                  backgroundColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectTimeDialog,
              child: Text(
                "مدة الجلسة: $_selectedMinutes دقيقة ⏱️",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Stay focused!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
