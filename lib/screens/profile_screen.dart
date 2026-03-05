import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/profile_menu_item.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.green),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    auth.userName ?? "Guest User",
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    auth.userEmail ?? "guest@example.com",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  Profile Options using Reusable Widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    subtitle: "Track your orders",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    title: "My Address",
                    subtitle: "Manage your address",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.payment_outlined,
                    title: "Payment Methods",
                    subtitle: "Saved cards and UPI",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    subtitle: "Manage your alerts",
                    onTap: () {},
                  ),
                  const Divider(height: 30),
                  ProfileMenuItem(
                    icon: Icons.logout,
                    title: "Logout",
                    subtitle: "Sign out from your account",
                    isLogout: true,
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
