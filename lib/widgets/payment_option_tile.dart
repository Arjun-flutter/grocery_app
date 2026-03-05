import 'package:flutter/material.dart';

class PaymentOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final String selectedValue;
  final Function(String) onChanged;

  const PaymentOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedValue == value;
    const Color primaryColor = Colors.white; // Changed to white for black background

    return ListTile(
      leading: Icon(icon, color: Colors.amber), // Amber icons look good on black
      title: Text(
        title, 
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
      ),
      subtitle: Text(
        subtitle, 
        style: const TextStyle(fontSize: 12, color: Colors.white70)
      ),
      trailing: Icon(
        isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
        color: isSelected ? Colors.amber : Colors.white24,
      ),
      onTap: () => onChanged(value),
    );
  }
}
