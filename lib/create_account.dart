// ============================================================================
// FILE: lib/create_account.dart
// DESCRIPTION: Create account screen with name, email, and password fields
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/animated_button.dart';

// Create account screen widget
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller for sliding transition when entering this screen
  late AnimationController _slideController;
  // Animation that moves content from right to left
  late Animation<Offset> _slideAnimation;
  // Animation for fade effect
  late Animation<double> _fadeAnimation;

  // Text controllers to store user input
  final nameController = TextEditingController();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Navigate back to sign-in screen
  void navigateBackToSignIn() {
    Navigator.of(context).pushReplacementNamed('/signin');
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
              // NPC Logo at top of screen with fade animation
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
                      // "Create account" label
                      Text(
                        'Create account',
                        style: GoogleFonts.orbitron(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Full name input field
                      TextField(
                        controller: nameController,
                        style: GoogleFonts.orbitron(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Full name',
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
                      
                      // Email input field
                      TextField(
                        controller: emailController,
                        style: GoogleFonts.orbitron(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email',
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
                      
                      // Button row with "Create" and "Cancel" buttons
                      Row(
                        children: [
                          // "Create" button - primary red button
                          Expanded(
                            child: AnimatedButton(
                              label: 'Create',
                              isPrimary: true,
                              onPressed: () {
                                // Handle account creation logic here
                                print('Name: ${nameController.text}');
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          // "Cancel" button - secondary outline button
                          // Navigates back to sign-in screen
                          Expanded(
                            child: AnimatedButton(
                              label: 'Cancel',
                              isPrimary: false,
                              onPressed: navigateBackToSignIn,
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