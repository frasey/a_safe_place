import 'package:a_safe_place/authentication/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:a_safe_place/authentication/widgets/form_container_widget.dart';
import 'package:a_safe_place/authentication/signup_page.dart';
import 'package:a_safe_place/Global/common/toast.dart';
import 'package:a_safe_place/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController =
      TextEditingController(text: "dave@gmail.com");
  TextEditingController _passwordController =
      TextEditingController(text: "123456");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Transform.translate(
      //     offset: Offset(0.0, 18.0),
      //     child: const Text("A Safe Place",
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 28,
      //       ),
      //     ),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "A Safe Place",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Color.fromARGB(255, 75, 184, 137),
                ),
              ),
              const SizedBox(height: 20),
              const FaIcon(
                FontAwesomeIcons.userSecret,
                size: 100,
                color: Color.fromARGB(255, 75, 184, 137),
              ),
              const SizedBox(height: 50),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 26, 58, 58),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 119, 104, 133),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: _isSigning
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 58, 58),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                          (route) => false);
                    },
                    child: const Text("Sign Up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 75, 184, 137),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showToast(message: "An error occurred");
    }
  }
}
