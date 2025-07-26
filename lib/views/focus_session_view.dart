import 'package:flutter/material.dart';
import 'package:focus_bubble/widgets/custom_buttom.dart';
import '../styles/app_colors.dart';

class FocusSessionView extends StatefulWidget {
  const FocusSessionView({super.key});

  @override
  State<FocusSessionView> createState() => _FocusSessionViewState();
}

class _FocusSessionViewState extends State<FocusSessionView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // ضروري لتوفير الموارد
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor, // Mint color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 6,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "24:58",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomBottom(
              onPressed: () {
                // Resume or Pause logic here
              },
              text: 'Pause',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
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
