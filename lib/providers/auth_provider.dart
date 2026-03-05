import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  bool get isAuthenticated => _user != null;
  String? get userName => _user?.displayName ?? _user?.email?.split('@')[0];
  String? get userEmail => _user?.email;

  AuthProvider() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Real Firebase Login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'user-not-found') message = "No user found for that email.";
      else if (e.code == 'wrong-password') message = "Wrong password provided.";
      else message = e.message ?? message;
      throw Exception(message);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // Real Firebase Signup
  Future<void> signup(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update display name
      await result.user?.updateDisplayName(name);
      _user = result.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message = "Sign up failed";
      if (e.code == 'weak-password') message = "The password provided is too weak.";
      else if (e.code == 'email-already-in-use') message = "An account already exists for that email.";
      else message = e.message ?? message;
      throw Exception(message);
    } catch (e) {
      throw Exception("Signup failed: $e");
    }
  }

  // Real Firebase Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed");
    }
  }
}
