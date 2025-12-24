import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class ItemCard extends StatelessWidget {
  final Map item;
  final int index;

  const ItemCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Item image (emoji or text)
          Text(item['image'], style: const TextStyle(fontSize: 50)),

          const SizedBox(height: 10),

          // Item name
          Text(item['name'], style: const TextStyle(fontSize: 18)),

          // Item price
          Text("₹${item['price']}", style: const TextStyle(fontSize: 16)),

          const SizedBox(height: 8),

          // Add to cart button
          ElevatedButton(
            onPressed: () {
              CartModel.add(item);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Added to cart")));
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
