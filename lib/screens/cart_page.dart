import 'package:flutter/material.dart';
import '../models/cart_model.dart';

/// Cart Screen
/// Displays items added to cart + total price

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // Calculate total price
    final total = CartModel.cart.fold(0, (sum, item) => sum + (item['price'] as int));

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),

      body: Column(
        children: [
          // 🧺 Cart Item List
          Expanded(
            child: ListView.builder(
              itemCount: CartModel.cart.length,
              itemBuilder: (_, i) {
                final item = CartModel.cart[i];

                return ListTile(
                  leading: Text(item['image'], style: const TextStyle(fontSize: 32)),
                  title: Text(item['name']),
                  subtitle: Text("₹${item['price']}"),

                  // ❌ Delete item
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() => CartModel.remove(item));
                    },
                  ),
                );
              },
            ),
          ),

          // 💰 Total section
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Total: ₹$total",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
