import 'package:bluecolorguy/auth/auth.dart';
import 'package:bluecolorguy/auth/registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 236, 255),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25),
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
                  controller: emailcontroller,
                  style: const TextStyle(fontSize: 18),
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
                Material(
                  color: const Color.fromARGB(255, 160, 212, 225),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await authService.signInWithEmailAndPassword(
                        emailcontroller.text,
                        passwordcontroller.text,
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "You don't have account? ",
                    style: const TextStyle(fontSize: 13, color: Colors.black),
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
    );
  }
}



// Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Registration(),
//                         ),
//                       );