import 'dart:async';

class PaymentService {
  // Simulates a payment gateway (like Stripe or Razorpay)
  Future<bool> processPayment(double amount) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 3));

    // Simulate successful payment 95% of the time
    // In a real app, you'd call your backend here to create a payment intent
    return true; 
  }
}
