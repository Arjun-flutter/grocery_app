import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const GroceryApp(),
    ),
  );
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // New Premium Color Palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B4332), // Deep Forest Green
          primary: const Color(0xFF1B4332),
          secondary: const Color(0xFFFFA000), // Amber Accent
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const SplashScreen(),
    );
  }
}
