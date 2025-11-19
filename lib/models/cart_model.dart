// Simple cart state manager.
class CartModel {
  // List of cart items
  static final List<Map<String, dynamic>> cart = [];

  // Adds item to cart
  static void add(item) => cart.add(item);

  // Removes item from cart
  static void remove(item) => cart.remove(item);
}
