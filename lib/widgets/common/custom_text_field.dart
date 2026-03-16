import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isObscure = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: Icon(widget.icon, color: const Color(0xFF0B845C)),
          // Added Visibility Toggle for password fields
          suffixIcon: widget.isObscure 
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
