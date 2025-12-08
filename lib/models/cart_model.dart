class CartModel {
  CartModel._privateConstructor();

  static final CartModel instance = CartModel._privateConstructor();

  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  void addItem(Map<String, dynamic> item) {
    // Try to find existing item by title
    final idx = _items.indexWhere((i) => i['title'] == item['title']);
    if (idx >= 0) {
      // increase quantity
      _items[idx]['quantity'] = (_items[idx]['quantity'] as int) + (item['quantity'] as int);
    } else {
      _items.add(Map<String, dynamic>.from(item));
    }
  }

  void removeItem(String title) {
    _items.removeWhere((i) => i['title'] == title);
  }

  void updateQuantity(String title, int quantity) {
    final idx = _items.indexWhere((i) => i['title'] == title);
    if (idx >= 0) {
      if (quantity <= 0) {
        _items.removeAt(idx);
      } else {
        _items[idx]['quantity'] = quantity;
      }
    }
  }

  void clear() => _items.clear();

  double get totalPrice => _items.fold(0.0, (sum, i) => sum + (i['price'] as double) * (i['quantity'] as int));

  int get totalItems => _items.fold(0, (sum, i) => sum + (i['quantity'] as int));
}
