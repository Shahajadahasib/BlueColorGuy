import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'signin.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _HomePageState();
}

class _HomePageState extends State<Registration> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final GlobalKey<FormState> _signupformKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    usernamecontroller.dispose();

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
              key: _signupformKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 8,
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
                    controller: usernamecontroller,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(fontSize: 18),
                    validator: RequiredValidator(errorText: 'Name is required'),
                    decoration: InputDecoration(
                      label: const Text("Name"),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 18),
                    validator:
                        RequiredValidator(errorText: 'Email is required'),
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: passwordcontroller,
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
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_signupformKey.currentState!.validate()) {
                          await authService.createUserWithEmailAndPassword(
                            usernamecontroller.text,
                            emailcontroller.text,
                            passwordcontroller.text,
                            context,
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "You Already have an account? ",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
