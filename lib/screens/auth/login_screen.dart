import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../home/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await context.read<AuthProvider>().login(email, password);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1B4332);
    //  Calculate responsive header height (35% of screen height)
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.35;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Responsive Header
          Container(
            height: headerHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [primaryColor, Color(0xFF081C15)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                // Align content to bottom of header
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    "Sign in to start fresh",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable Form Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  CustomTextField(
                    hint: "Email",
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: "Password",
                    icon: Icons.lock_outline_rounded,
                    controller: _passwordController,
                    isObscure: true,
                  ),

                  const SizedBox(height: 30),

                  _isLoading
                      ? const CircularProgressIndicator(color: primaryColor)
                      : SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              shadowColor: primaryColor.withOpacity(0.4),
                            ),
                            child: const Text(
                              "GET STARTED",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "New user?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
