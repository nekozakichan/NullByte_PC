import 'package:flutter/material.dart';
import 'models/cart_model.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFEB2316);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: Text(product['title'] ?? '' , style: const TextStyle(color: redColor)),
        iconTheme: const IconThemeData(color: redColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product['imagePath'] ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      'No Image',
                      style: TextStyle(color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['title'] ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product['description'] ?? '',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            const Text(
              'Key Specifications',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  product['specs'] ?? 'No specifications available.',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: redColor),
                    onPressed: () {
                      // add to cart
                      CartModel.instance.addItem({
                        'tag': product['tag'] ?? '',
                        'title': product['title'] ?? '',
                        'price': (product['price'] is String) ? double.tryParse((product['price'] as String).replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0 : (product['price'] ?? 0.0),
                        'quantity': 1,
                        'imagePath': product['imagePath'] ?? '',
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                    },
                    child: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
