import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureTextPass = true;
  bool _obscureTextConfPass = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
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
              const SizedBox(height: 16.0),
              Text(
                'Create your account',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureTextPass,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureTextPass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureTextPass = !_obscureTextPass;
                      });
                    },
                  ),
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value != _confirmPassController.text) {
                    return "Password doesnt match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _confirmPassController,
                obscureText: _obscureTextConfPass,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureTextConfPass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureTextConfPass = !_obscureTextConfPass;
                      });
                    },
                  ),
                  hintText: 'Password Confirmation',
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Password doesnt match";
                  }
                  return null;
                },
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
                  var validate = _formKey.currentState!.validate();
                  if (validate) {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final confPass = _confirmPassController.text;

                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      // Tampilkan dialog sukses jika berhasil
                      AlertDialog alert = AlertDialog(
                        title: const Text("Register Success"),
                        content: const Text("Success Registered an Account"),
                        actions: [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () =>
                                Navigation.intentNoData(LoginPage.routeName),
                          ),
                        ],
                      );
                      showDialog(context: context, builder: (context) => alert);
                      return;
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                child: const Text('Register'),
              ),
              TextButton(
                child: const Text('Already have an account? Login'),
                onPressed: () => Navigation.back(),
              ),
            ],
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
