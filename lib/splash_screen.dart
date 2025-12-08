// ============================================================================
// FILE: lib/splash_screen.dart
// DESCRIPTION: Splash screen with animated logo that displays on app startup
// ============================================================================

import 'package:flutter/material.dart';
import 'sign_in.dart';

// Splash screen widget that shows animated NullByte PC logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller manages the duration and timing of animations
  late AnimationController _animationController;
  // Animation for opacity (fade effect) - transitions from 0 to 1
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller with 3 second duration
    // vsync: this prevents tearing and syncs with screen refresh rate
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Create fade animation using Tween:
    // Tween defines the range (0.0 = transparent, 1.0 = opaque)
    // CurvedAnimation applies easing curve for smooth acceleration
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start the animation immediately
    _animationController.forward();

    // Listen for animation completion
    _animationController.addStatusListener((status) {
      // When animation finishes, navigate to SignIn screen
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            // Use pushReplacement to remove splash screen from navigation stack
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Always clean up animation controller to prevent memory leaks
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // FadeTransition applies the fade animation to its child widget
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // NPC Logo - display image from assets
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
}  }