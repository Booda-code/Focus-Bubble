import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_bubble/simple_bloc_observer.dart';
import 'package:focus_bubble/views/home_view.dart';
import 'package:hive_flutter/adapters.dart';

import 'cubits/theme_cubit.dart';
import 'models/app_settings_model.dart';
import 'models/daily_stats_model.dart';
import 'models/focus_session_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FocusSessionModelAdapter());
  Hive.registerAdapter(DailyStatsModelAdapter());
  Hive.registerAdapter(AppSettingsModelAdapter());

  final focusSessionBox = await Hive.openBox<FocusSessionModel>('sessions');

  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
      create: (_) => ThemeCubit(),
      child: FocusBubble(focusSessionBox)));
}

class FocusBubble extends StatelessWidget {
  final Box<FocusSessionModel> focusSessionBox;

  const FocusBubble(this.focusSessionBox, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: HomeView(),
        );
      },

    );
  }
}
