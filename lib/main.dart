import 'package:flutter/material.dart';
import 'package:focus_bubble/views/home_view.dart';

void main() {
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
