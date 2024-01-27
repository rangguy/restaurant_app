import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  late User? _activeUser;

  @override
  void initState() {
    super.initState();
    checkAutoLogin();
  }

  Future<void> checkAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userUid = prefs.getString('user-uid');

    if (userUid != null) {
      Future.delayed(const Duration(seconds: 3), () {
        autoLoginSuccess();
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        showLoginPage();
      });
    }
  }

  void autoLoginSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  void showLoginPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  void getCurrentUser() async {
    try {
      _activeUser = _auth.currentUser;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu_outlined,
              size: 150,
              color: Color(0xFF132A3A),
            ),
            SizedBox(height: 10),
            Text(
              'Cafrestapp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
