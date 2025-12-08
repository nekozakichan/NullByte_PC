// ============================================================================
// FILE: lib/models/favorites_model.dart
// DESCRIPTION: Global favorites management (singleton pattern)
// ============================================================================

class FavoritesModel {
  static final FavoritesModel _instance = FavoritesModel._privateConstructor();

  factory FavoritesModel() {
    return _instance;
  }

  FavoritesModel._privateConstructor();

  static FavoritesModel get instance => _instance;

  // Favorites list: stores favorite product maps
  final List<Map<String, dynamic>> _favorites = [];

  // Get all favorites
  List<Map<String, dynamic>> get items => _favorites;

  // Check if product is favorited by title
  bool isFavorited(String title) {
    return _favorites.any((fav) => fav['title'] == title);
  }

  // Add item to favorites
  void addItem(Map<String, dynamic> product) {
    if (!isFavorited(product['title'])) {
      _favorites.add(product);
    }
  }

  // Remove item from favorites by title
  void removeItem(String title) {
    _favorites.removeWhere((fav) => fav['title'] == title);
  }

  // Toggle favorite (add if not favorited, remove if favorited)
  void toggleFavorite(Map<String, dynamic> product) {
    if (isFavorited(product['title'])) {
      removeItem(product['title']);
    } else {
      addItem(product);
    }
  }

  // Clear all favorites
  void clear() {
    _favorites.clear();
  }

  // Get total number of favorites
  int get totalItems => _favorites.length;
}
