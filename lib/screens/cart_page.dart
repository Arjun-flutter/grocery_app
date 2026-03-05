import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_payment_panel.dart';
import '../widgets/payment_option_tile.dart';
import '../widgets/processing_overlay.dart';
import '../services/payment_service.dart';
import 'payment_success_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isProcessing = false;
  String _selectedPaymentMethod = "UPI";
  final PaymentService _paymentService = PaymentService();

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Transparent to show custom shape
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: Color(0xFF121212), // Deep Black Background
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              PaymentOptionTile(
                icon: Icons.account_balance_wallet_rounded,
                title: "Google Pay / UPI",
                subtitle: "Fast and Secure",
                value: "UPI",
                selectedValue: _selectedPaymentMethod,
                onChanged: (val) {
                  setModalState(() => _selectedPaymentMethod = val);
                  setState(() {});
                },
              ),
              PaymentOptionTile(
                icon: Icons.credit_card_rounded,
                title: "Credit / Debit Card",
                subtitle: "All major cards accepted",
                value: "CARD",
                selectedValue: _selectedPaymentMethod,
                onChanged: (val) {
                  setModalState(() => _selectedPaymentMethod = val);
                  setState(() {});
                },
              ),
              PaymentOptionTile(
                icon: Icons.money_rounded,
                title: "Cash on Delivery",
                subtitle: "Pay when you receive",
                value: "COD",
                selectedValue: _selectedPaymentMethod,
                onChanged: (val) {
                  setModalState(() => _selectedPaymentMethod = val);
                  setState(() {});
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA000), // Amber Gold
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text("CONFIRM & PAY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCheckout() async {
    final cart = context.read<CartProvider>();
    setState(() => _isProcessing = true);

    try {
      bool success = await _paymentService.processPayment(cart.totalAmount);
      if (success && mounted) {
        cart.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed: $e")));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("My Basket", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: cart.items.isEmpty
          ? _buildEmptyCart(context)
          : Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 220),
                  itemCount: cartItems.length,
                  itemBuilder: (ctx, i) => CartItemTile(item: cartItems[i]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CartPaymentPanel(
                    cart: cart,
                    isProcessing: _isProcessing,
                    onCheckout: _showPaymentSheet,
                  ),
                ),
                if (_isProcessing) const ProcessingOverlay(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_basket_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text("Your basket is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.maybePop(context),
            child: const Text("Start Shopping"),
          )
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Clear Cart?"),
        content: const Text("Are you sure you want to remove all items?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("No")),
          TextButton(
            onPressed: () {
              cart.clear();
              Navigator.pop(ctx);
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
