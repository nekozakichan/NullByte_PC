// ============================================================================
// FILE: lib/menu_drawer.dart
// DESCRIPTION: Menu drawer widget for navigation and brand selection
// ============================================================================

import 'package:flutter/material.dart';
import 'cart_screen.dart';

/// Menu Drawer Widget
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Defined data for the menu items and brands to keep the code clean
    final List<String> menuItems = [
      "Home",
      "Search",
      "Cart",
      "Favorites",
      "Profile"
    ];

    final List<String> brands = [
      "ASUS",
      "MSI",
      "Razer",
      "Alienware",
      "Gigabyte",
      "Corsair"
    ];

    const redColor = Color(0xFFEB2316);

    return Drawer(
      // The dark background color from the image
      backgroundColor: const Color(0xFF1E1E1E),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION 1: HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Menu",
                        style: TextStyle(
                          color: redColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Navigate",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // The 'X' Close Button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- SECTION 2: NAVIGATION LINKS ---
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle navigation based on menu item
                        if (menuItems[index] == 'Cart') {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          menuItems[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // --- SECTION 3: BRANDS GRID ---
              const Text(
                "Brands",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: brands.map((brand) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      brand,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}