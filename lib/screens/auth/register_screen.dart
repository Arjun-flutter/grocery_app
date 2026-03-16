import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../home/main_navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await context.read<AuthProvider>().signup(name, email, password);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1B4332);
    //  Calculate responsive header height (30% of screen height)
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.30;

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
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, Color(0xFF081C15)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const BackButton(color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    "Join Us!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    "Start fresh today",
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
                    hint: "Full Name",
                    icon: Icons.person_outline,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
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
                  
                  const SizedBox(height: 40),
                  
                  _isLoading
                      ? const CircularProgressIndicator(color: primaryColor)
                      : SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _handleSignup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 8,
                            ),
                            child: const Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  
                  const SizedBox(height: 30),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Already a member?", style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Log In", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
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
