import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          //  Product Image with Discount Badge
          Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(item.product.image, fit: BoxFit.contain),
              ),
              if (item.product.discountPercentage > 0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "${item.product.discountPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),

          //  Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "₹${(item.product.price * 80).toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    if (item.product.discountPercentage > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        "₹${((item.product.price / (1 - item.product.discountPercentage / 100)) * 80).toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          //  Quantity & 🗑️ Delete Controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => cart.removeItem(item.product.id),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _quantityButton(Icons.remove, () {
                    cart.removeSingleItem(item.product.id);
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${item.quantity}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _quantityButton(Icons.add, () {
                    cart.addItem(item.product);
                  }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.green),
      ),
    );
  }
}
