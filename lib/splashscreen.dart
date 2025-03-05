import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project/Screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for rotation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // Same as the splash screen duration
    )..repeat(); // Repeat animation indefinitely

    // Delayed navigation after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF014C07), // Fully opaque green background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rotating icon
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * 3.1416, // Full rotation
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.eco, // Plant leaf icon
                  color: Colors.greenAccent,
                  size: 100, // Adjust icon size
                ),
              ),
              const SizedBox(height: 20), // Spacing between icon and text

              // Styled text
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Plant",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White color for "Plant"
                      ),
                    ),
                    TextSpan(
                      text: " Care",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent, // Green accent for "Care"
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

