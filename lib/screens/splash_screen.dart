import 'dart:async';
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B845C), // Deep Emerald Green
      body: Stack(
        children: [
          //  Background Patterns
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Unique Icon Design
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.local_mall_rounded,
                      size: 80,
                      color: Color(0xFF0B845C),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                //  App Name with unique styling
                const Text(
                  "FRESH MART",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 5,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA000), // Amber Accent
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                const Text(
                  "Your Daily Fresh Choice",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          //  Bottom Loader
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFA000),
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
