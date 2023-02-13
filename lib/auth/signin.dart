import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'registration.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _signinformKey = GlobalKey<FormState>();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => FlutterNativeSplash.remove(),
    );

    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25),
            child: Form(
              key: _signinformKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 9,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo2.jpg'),
                    radius: 80,
                  ),
                  SizedBox(
                    height: size.height / 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.sentences,
                    controller: emailcontroller,
                    style: const TextStyle(fontSize: 18),
                    validator:
                        RequiredValidator(errorText: 'Email is required'),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      label: const Text("Email"),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 18),
                    controller: passwordcontroller,
                    obscureText: true,
                    validator:
                        RequiredValidator(errorText: 'Password is required'),
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_signinformKey.currentState!.validate()) {
                          await authService.signInWithEmailAndPassword(
                            emailcontroller.text.trim(),
                            passwordcontroller.text.trim(),
                            context,
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "You don't have account? ",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Registration',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Registration(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
