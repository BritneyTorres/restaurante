import 'package:flutter_nuevo/dish.dart';

class CartItem {
  final Dish dish;
  int quantity;

  CartItem({required this.dish, this.quantity = 1});

  double get totalPrice => dish.price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(dish: dish, quantity: quantity ?? this.quantity);
  }
}

class CartService {
  static final List<CartItem> _items = [];
  static final List<Function()> _listeners = [];

  // Getter inmutable para los items
  static List<CartItem> get items => List.unmodifiable(_items);

  // Método para suscribirse a cambios
  static void addListener(Function() listener) {
    _listeners.add(listener);
  }

  // Método para remover suscripción
  static void removeListener(Function() listener) {
    _listeners.remove(listener);
  }

  // Notificar a todos los listeners
  static void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  static void addToCart(Dish dish) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.dish.id == dish.id,
    );

    if (existingItemIndex >= 0) {
      _items[existingItemIndex] = _items[existingItemIndex].copyWith(
        quantity: _items[existingItemIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(dish: dish));
    }
    _notifyListeners();
  }

  static void removeFromCart(String dishId) {
    _items.removeWhere((item) => item.dish.id == dishId);
    _notifyListeners();
  }

  static void updateQuantity(String dishId, int newQuantity) {
    final itemIndex = _items.indexWhere((item) => item.dish.id == dishId);

    if (itemIndex >= 0) {
      if (newQuantity <= 0) {
        _items.removeAt(itemIndex);
      } else {
        _items[itemIndex] = _items[itemIndex].copyWith(quantity: newQuantity);
      }
      _notifyListeners();
    }
  }

  static void clearCart() {
    _items.clear();
    _notifyListeners();
  }

  static double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  static int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  static bool get isEmpty => _items.isEmpty;

  // Nuevo método para obtener un item específico
  static CartItem? getItem(String dishId) {
    try {
      return _items.firstWhere((item) => item.dish.id == dishId);
    } catch (e) {
      return null;
    }
  }
}
