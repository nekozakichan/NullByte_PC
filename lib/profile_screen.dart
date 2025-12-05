// ============================================================================
// FILE: lib/profile_screen.dart
// DESCRIPTION: User profile screen with account details and settings
// ============================================================================

import 'package:flutter/material.dart';
import 'package:npc/favorites_screen.dart';
import 'package:npc/home_page.dart';
import 'package:npc/search_screen.dart';
import 'cart_screen.dart';

// Profile Screen Widget
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Track which nav item is selected
  int _selectedIndex = 4; // 4 for Profile

  // Dark background color used throughout your UI
  static const backgroundColor = Color(0xFF121212);
  static const redColor = Color(0xFFEB2316);
  static const cardColor = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 25,
            color: redColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Profile Header
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(color: redColor, width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white.withOpacity(0.3),
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User Email
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Edit Profile Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          // Edit profile action
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Account Section
              _buildSectionTitle('Account'),
              const SizedBox(height: 12),
              _buildMenuOption(
                icon: Icons.shopping_bag_outlined,
                label: 'My Orders',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.location_on_outlined,
                label: 'Addresses',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.payment_outlined,
                label: 'Payment Methods',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // Preferences Section
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 12),
              _buildMenuOption(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.language_outlined,
                label: 'Language',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.dark_mode_outlined,
                label: 'Dark Mode',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // Support Section
              _buildSectionTitle('Support'),
              const SizedBox(height: 12),
              _buildMenuOption(
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.info_outline,
                label: 'About Us',
                onTap: () {},
              ),
              _buildMenuOption(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // Logout action
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: cardColor,
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform logout
                              Navigator.pop(context);
                              // Navigate to sign in
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/signin',
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: redColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      // Floating Navigation Bar
      floatingActionButton: _buildFloatingNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Build section title
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Build menu option
  Widget _buildMenuOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: redColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Build floating navigation bar
  Widget _buildFloatingNav() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: redColor.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: redColor.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Home'),
            _buildNavItem(1, Icons.search_rounded, 'Search'),
            _buildNavItem(2, Icons.shopping_cart_rounded, 'Cart'),
            _buildNavItem(3, Icons.favorite_rounded, 'Favorites'),
            _buildNavItem(4, Icons.person_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  // Build individual nav item
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _handleNavigation(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? redColor : Colors.white54,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? redColor : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }

  // Handle navigation
  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 1:
        // Navigate to Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
        break;
      case 2:
        // Navigate to Cart
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
        break;
      case 3:
        // Navigate to Favorites
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FavoritesScreen()),
        );

        break;
      case 4:
        // Already on Profile
        break;
    }
  }
}