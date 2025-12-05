// ============================================================================
// FILE: lib/screens/widgets/animated_button.dart
// DESCRIPTION: Reusable animated button widget with scale animation on press
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Reusable animated button widget for consistent button styling across app
class AnimatedButton extends StatefulWidget {
  // Label text displayed on the button
  final String label;
  // determines if button is primary (red) or secondary (outline)
  final bool isPrimary;
  // Callback function when button is pressed
  final VoidCallback onPressed;

  const AnimatedButton({
    super.key,
    required this.label,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  // Track whether button is currently being pressed
  bool isPressed = false;
  
  // Animation controller manages the button press animation duration
  late AnimationController _pressController;
  // Animation that scales button smaller when pressed
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize button press animation controller with 150ms duration
    // vsync: this syncs animation with screen refresh rate to prevent tearing
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Create scale animation:
    // Tween<double>(begin: 1.0, end: 0.95) = button shrinks to 95% size
    // When _pressController value = 0.0, scale = 1.0
    // When _pressController value = 1.0, scale = 0.95
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // Clean up animation controller to prevent memory leaks
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Called when user starts pressing the button
      onTapDown: (_) {
        // Play the scale animation forward
        _pressController.forward();
        setState(() => isPressed = true);
      },
      // Called when user releases the button
      onTapUp: (_) {
        // Reverse the scale animation
        _pressController.reverse();
        setState(() => isPressed = false);
        // Execute the callback function passed by parent widget
        widget.onPressed();
      },
      // Called if user cancels the tap (e.g., drags finger away)
      onTapCancel: () {
        // Reverse animation without calling onPressed
        _pressController.reverse();
        setState(() => isPressed = false);
      },
      // ScaleTransition applies the scale animation to the child
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          // Vertical padding creates button height
          padding: const EdgeInsets.symmetric(vertical: 14),
          // Decoration defines button appearance
          decoration: BoxDecoration(
            // Primary button = solid red background
            // Secondary button = transparent with border
            color: widget.isPrimary ? const Color.fromRGBO(227, 28, 28, 1) : Colors.transparent,
            // Border only on secondary buttons
            border: widget.isPrimary
                ? null
                : Border.all(color: Colors.grey[700]!, width: 1.5),
            // Rounded corners for modern look
            borderRadius: BorderRadius.circular(8),
          ),
          // Center the text content within the button
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.orbitron(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                // White text for primary, grey for secondary
                color: widget.isPrimary ? Colors.white : Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}