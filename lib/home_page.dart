import 'package:flutter/material.dart';
import 'menu_drawer.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';
import 'models/cart_model.dart';
import 'models/favorites_model.dart';
import 'product_detail.dart';

void main() {
  runApp(const NullBytePCMainPage());
}

class NullBytePCMainPage extends StatelessWidget {
  const NullBytePCMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// Main HomePage widget with floating navigation
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Track which nav item is selected (0=Home, 1=Search, 2=Favorites, 3=Profile)
  int _selectedIndex = 0;

  // Dark background color used throughout your UI
  static const backgroundColor = Color(0xFF121212);
  static const redColor = Color(0xFFEB2316);
  static const cardColor = Color(0xFF1E1E1E);

  // Global key to access Scaffold state for opening drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,  // to remove the default hamberuger icon
        elevation: 0,
        title: const Text(
          'NullByte PC',
          style: TextStyle(
            fontSize: 25,
            color: redColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: redColor,
              onPressed: () {
                // Open the drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Premium gaming hardware for enthusiasts',
                style: TextStyle(
                  fontSize: 13,
                  color: redColor.withOpacity(0.85),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Special offer card
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ROG Strix Limited',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ultimate performance for pro gamers — limited stock',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // "Shop Now" action
                            },
                            child: const Text('Shop Now', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: redColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // "Notify me" action
                            },
                            child: const Text(
                              'Notify me',
                              style: TextStyle(color: redColor, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /// Categories header and row
              const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: CategoryCard(title: 'Laptops')),
                  const SizedBox(width: 8),
                  Expanded(child: CategoryCard(title: 'Desktops')),
                  const SizedBox(width: 8),
                  Expanded(child: CategoryCard(title: 'Peripherals')),
                ],
              ),

              const SizedBox(height: 16),

              /// Featured Products Header
              const Text(
                'Featured Products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// Featured Product grid
              const SizedBox(height: 10),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
                children: [
                  ProductCard(
                    tag: 'ASUS',
                    title: 'ASUS ROG Strix G15 - RTX 4080',
                    description: 'Limited Edition • High-End',
                    price: '\$2,499',
                    imagePath: 'assets/images/asus_rog_strix.png',
                    specs: 'CPU: AMD Ryzen 9\nGPU: RTX 4080\nRAM: 32GB\nStorage: 1TB NVMe',
                  ),
                  ProductCard(
                    tag: 'MSI',
                    title: 'MSI Stealth GS77 - RTX 4090',
                    description: 'Limited Edition • High-End',
                    price: '\$2,499',
                    imagePath: 'assets/images/msi_stealth.png',
                    specs: 'CPU: Intel Core i9\nGPU: RTX 4090\nRAM: 32GB\nStorage: 2TB NVMe',
                  ),
                  ProductCard(
                    tag: 'ASUS',
                    title: 'ASUS ROG Flow X16 - OLED',
                    description: 'Limited Edition • High-End',
                    price: '\$2,499',
                    imagePath: 'assets/images/asus_rog_flow.png',
                    specs: 'CPU: AMD Ryzen 9\nGPU: RTX 4070\nRAM: 32GB\nStorage: 1TB NVMe',
                  ),
                  ProductCard(
                    tag: 'Razer',
                    title: 'Razer Blade 15 - Advanced Edition',
                    description: 'Limited Edition • High-End',
                    price: '\$2,499',
                    imagePath: 'assets/images/razer_blade.png',
                    specs: 'CPU: Intel Core i7\nGPU: RTX 3080\nRAM: 16GB\nStorage: 1TB NVMe',
                  ),
                  ProductCard(
                    tag: 'Alienware',
                    title: 'Alienware m17 R5 - RTX 3080',
                    description: 'Premium Gaming • High-End',
                    price: '\$2,199',
                    imagePath: 'assets/images/alienware_m17.png',
                    specs: 'CPU: AMD Ryzen 7\nGPU: RTX 3080\nRAM: 32GB\nStorage: 1TB NVMe',
                  ),
                  ProductCard(
                    tag: 'Corsair',
                    title: 'Corsair Gaming Bundle',
                    description: 'RGB • Wireless',
                    price: '\$299',
                    imagePath: 'assets/images/corsair_bundle.png',
                    specs: 'Includes: Keyboard, Mouse, Headset\nConnectivity: Wireless',
                  ),
                  ProductCard(
                    tag: 'Gigabyte',
                    title: 'Gigabyte AORUS Gaming Laptop',
                    description: 'High Performance • RTX 4070',
                    price: '\$1,899',
                    imagePath: 'assets/images/gigabyte_aorus.png',
                    specs: 'CPU: Intel Core i7\nGPU: RTX 4070\nRAM: 16GB\nStorage: 1TB NVMe',
                  ),
                  ProductCard(
                    tag: 'ASUS',
                    title: 'ASUS TUF Gaming A15',
                    description: 'Durable • Performance',
                    price: '\$1,499',
                    imagePath: 'assets/images/asus_tuf.jpg',
                    specs: 'CPU: AMD Ryzen 7\nGPU: RTX 4060\nRAM: 16GB\nStorage: 512GB NVMe',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Floating Navigation Bar
      floatingActionButton: _buildFloatingNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Build floating navigation bar
  Widget _buildFloatingNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: redColor.withOpacity(0.3), width: 1),
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
        // Handle navigation
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
        // Already on Home
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
        // Navigate to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }
}

/// Widget for category boxes
class CategoryCard extends StatelessWidget {
  final String title;
  const CategoryCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF1E1E1E);
    return GestureDetector(
      onTap: () {
        // Handle category tap
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for individual featured products
class ProductCard extends StatefulWidget {
  final String tag;
  final String title;
  final String description;
  final String price;
  final String imagePath;
  final String specs;

  const ProductCard({
    Key? key,
    required this.tag,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.specs,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = FavoritesModel.instance.isFavorited(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF1E1E1E);
    const redColor = Color(0xFFEB2316);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetail(product: {
              'tag': widget.tag,
              'title': widget.title,
              'description': widget.description,
              'price': widget.price,
              'imagePath': widget.imagePath,
              'specs': widget.specs,
            }),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with favorite icon
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  // Favorite heart icon (top-right)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                        FavoritesModel.instance.toggleFavorite({
                          'tag': widget.tag,
                          'title': widget.title,
                          'description': widget.description,
                          'price': widget.price,
                          'imagePath': widget.imagePath,
                          'specs': widget.specs,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isFavorited ? 'Added to favorites' : 'Removed from favorites',
                            ),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: redColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Product brand/tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: redColor),
              ),
              child: Text(
                widget.tag.toUpperCase(),
                style: const TextStyle(
                  color: redColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Product title
            Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 3),

            // Description
            Text(
              widget.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 9,
              ),
            ),

            const SizedBox(height: 6),

            // Add to Cart button and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      textStyle: const TextStyle(fontSize: 10),
                    ),
                    onPressed: () {
                      // Add to cart action
                      final parsedPrice = double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
                      CartModel.instance.addItem({
                        'tag': widget.tag,
                        'title': widget.title,
                        'price': parsedPrice,
                        'quantity': 1,
                        'imagePath': widget.imagePath,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    },
                    child: const Text('Add to Cart', style: TextStyle(fontSize: 9)),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}