import 'package:flutter/material.dart';

class ProcessingOverlay extends StatelessWidget {
  final String message;
  final String subMessage;

  const ProcessingOverlay({
    super.key,
    this.message = "Connecting to Bank...",
    this.subMessage = "Your transaction is being secured",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Color(0xFF1B4332), strokeWidth: 2),
            const SizedBox(height: 30),
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/10014/10014883.png",
              height: 100,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, size: 100, color: Color(0xFF1B4332)),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              subMessage,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
