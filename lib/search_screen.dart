// ============================================================================
// FILE: lib/search_screen.dart
// DESCRIPTION: Search screen with search bar and product results
// ============================================================================

import 'package:flutter/material.dart';
import 'package:npc/favorites_screen.dart';
import 'package:npc/home_page.dart';
import 'package:npc/profile_screen.dart';
import 'cart_screen.dart';

// Search Screen Widget
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Track which nav item is selected
  int _selectedIndex = 1; // 1 for Search

  // Search controller
  final TextEditingController _searchController = TextEditingController();

  // Dark background color used throughout your UI
  static const backgroundColor = Color(0xFF121212);
  static const redColor = Color(0xFFEB2316);
  static const cardColor = Color(0xFF1E1E1E);

  // Sample search results
  final List<Map<String, String>> searchResults = [
    {
      'tag': 'ASUS',
      'title': 'ASUS ROG Strix G15 - RTX 4080',
      'description': 'Limited Edition • High-End',
      'price': '\$2,499',
    },
    {
      'tag': 'MSI',
      'title': 'MSI Stealth GS77 - RTX 4090',
      'description': 'Limited Edition • High-End',
      'price': '\$2,499',
    },
    {
      'tag': 'Razer',
      'title': 'Razer Blade 15 - Advanced Edition',
      'description': 'Limited Edition • High-End',
      'price': '\$2,899',
    },
    {
      'tag': 'Alienware',
      'title': 'Alienware m17 R5 - RTX 3080',
      'description': 'Premium Gaming • High-End',
      'price': '\$2,199',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Search Products',
          style: TextStyle(
            fontSize: 25,
            color: redColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: redColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Search Icon
                  Icon(
                    Icons.search,
                    color: redColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  // Search Input Field
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search for laptops, desktops...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  // Clear Button
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: redColor,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search Results or Empty State
            if (_searchController.text.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        color: Colors.white24,
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Start typing to search',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Search Results List
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final product = searchResults[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Product Image Placeholder
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Image',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Tag
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: redColor, width: 1),
                                    ),
                                    child: Text(
                                      product['tag']!.toUpperCase(),
                                      style: const TextStyle(
                                        color: redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // Product Title
                                  Text(
                                    product['title']!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Product Description
                                  Text(
                                    product['description']!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Price and Add Button
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product['price']!,
                                  style: const TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: redColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                  ),
                                  onPressed: () {
                                    // Add to cart action
                                  },
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      // Floating Navigation Bar
      floatingActionButton: _buildFloatingNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        // Navigate to Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 1:
        // Already on Search
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
        // Navigate to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }
}