// ============================================================================
// FILE: lib/sign_in.dart
// DESCRIPTION: Sign-in screen with email and password fields
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/animated_button.dart';

// Sign-in screen widget
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller for sliding transition when entering this screen
  late AnimationController _slideController;
  // Animation that moves content from right to left
  late Animation<Offset> _slideAnimation;
  // Animation for fade effect
  late Animation<double> _fadeAnimation;

  // Text controllers to store user input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Initialize slide animation controller with 800ms duration for smooth animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create slide animation:
    // Offset(1.0, 0.0) = starts at right side of screen
    // Offset.zero = ends at normal position
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOutQuart));

    // Create fade animation for opacity effect (0 = transparent, 1 = visible)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOutQuart),
    );

    // Start animation when screen loads
    _slideController.forward();
  }

  @override
  void dispose() {
    // Clean up controllers and text input fields
    _slideController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Navigate to create account screen
  void navigateToCreateAccount() {
    Navigator.of(context).pushReplacementNamed('/createaccount');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // NPC Logo - display image from assets with fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 60),
              
              // SlideTransition animates the form sliding in from right to left with fade
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Sign in" label
                      Text(
                        'Sign in',
                        style: GoogleFonts.orbitron(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Email input field
                      TextField(
                        controller: emailController,
                        style: GoogleFonts.orbitron(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: GoogleFonts.orbitron(color: Colors.grey),
                          // filled: true creates a background color
                          filled: true,
                          fillColor: Colors.grey[900],
                          // Border configuration
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Password input field
                      TextField(
                        controller: passwordController,
                        // obscureText: true hides password characters
                        obscureText: true,
                        style: GoogleFonts.orbitron(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.orbitron(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[900],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Button row with "Sign in" and "Create Account" buttons
                      Row(
                        children: [
                          // "Sign in" button - primary red button
                          Expanded(
                            child: AnimatedButton(
                              label: 'Sign in',
                              isPrimary: true,
                              onPressed: () {
                                // Handle login logic here
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');
                                // Navigate to home page after successful login
                                Navigator.of(context).pushReplacementNamed('/home');
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          // "Create Account" button - secondary outline button
                          // Navigates to create account screen
                          Expanded(
                            child: AnimatedButton(
                              label: 'Create Account',
                              isPrimary: false,
                              onPressed: navigateToCreateAccount,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}