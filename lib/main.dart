// ============================================================================
// FILE: lib/main.dart
// DESCRIPTION: Main entry point with routing configuration
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen.dart';
import 'sign_in.dart';
import 'create_account.dart';
import 'home_page.dart';

void main() {
  runApp(const NullBytePC());
}

// Main app widget with named routes
class NullBytePC extends StatelessWidget {
  const NullBytePC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: 'NullByte PC',
      // Dark theme configuration
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.red,
        fontFamily: GoogleFonts.orbitron().fontFamily,
      ),
      // Splash screen is the initial screen shown
      home: const SplashScreen(),
      // Define named routes for navigation
      routes: {
        // Route for splash screen
        '/splash': (context) => const SplashScreen(),
        // Route for sign in screen
        '/signin': (context) => const SignInScreen(),
        // Route for create account screen
        '/createaccount': (context) => const CreateAccountScreen(),
        // Route for home page
        '/home': (context) => const HomePage(),
      },
      // Remove debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}