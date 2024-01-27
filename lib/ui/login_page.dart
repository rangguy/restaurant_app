import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/register_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(),
                Hero(
                  tag: 'Restaurant App',
                  child: Text(
                    'Restaurant App',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 24.0),
                MaterialButton(
                  color: Colors.green,
                  textTheme: ButtonTextTheme.primary,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      // Melakukan otentikasi pengguna
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Mendapatkan objek User dari UserCredential
                      User? user = userCredential.user;

                      // Memastikan user tidak null sebelum menyimpan uid ke SharedPreferences
                      if (user != null) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('user-uid', user.uid);
                        // Tampilkan dialog sukses jika berhasil
                        AlertDialog alert = AlertDialog(
                          title: const Text("Login Success"),
                          content: Text("Welcome to CafRestApp $email!"),
                          actions: [
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigation.intentNoData(HomePage.routeName);
                              },
                            ),
                          ],
                        );
                        showDialog(
                            context: context, builder: (context) => alert);
                        return;
                      } else {
                        print("Error: User is null");
                      }
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  child: const Text(
                    'Does not have an account yet? Register here',
                  ),
                  onPressed: () =>
                      Navigation.intentNoData(RegisterPage.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
