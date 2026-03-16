import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';

class CartPaymentPanel extends StatelessWidget {
  final CartProvider cart;
  final bool isProcessing;
  final VoidCallback onCheckout;

  const CartPaymentPanel({
    super.key,
    required this.cart,
    required this.isProcessing,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subtotal & Delivery Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSimpleInfo("Subtotal", "₹${(cart.subtotalAmount * 80).toStringAsFixed(0)}"),
              Container(height: 25, width: 1, color: Colors.white24),
              _buildSimpleInfo(
                "Delivery",
                cart.deliveryCharge == 0 ? "FREE" : "₹${cart.deliveryCharge.toStringAsFixed(0)}",
                color: cart.deliveryCharge == 0 ? Colors.lightGreenAccent : Colors.orangeAccent,
              ),
            ],
          ),
          
          //  Divider between Billing and Total
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white12, height: 1),
          ),

          //  Total & Pay Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Payable", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Text(
                    "₹${cart.totalAmount.toStringAsFixed(0)}",
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: 130,
                child: ElevatedButton(
                  onPressed: isProcessing ? null : onCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA000),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("PAY NOW", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleInfo(String label, String value, {Color color = Colors.white}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
