import 'package:bluecolorguy/auth/auth.dart';
import 'package:bluecolorguy/auth/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _HomePageState();
}

class _HomePageState extends State<Registration> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
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
      backgroundColor: const Color.fromARGB(255, 234, 236, 255),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25),
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
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    label: const Text("Name"),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  color: const Color.fromARGB(255, 160, 212, 225),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      await authService.createUserWithEmailAndPassword(
                        usernamecontroller.text,
                        emailcontroller.text,
                        passwordcontroller.text,
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                      child: Text(
                        "Sign Up",
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
                    text: "You Already have an account? ",
                    style: const TextStyle(fontSize: 13, color: Colors.black),
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
    );
  }
}





//  await authService.createUserWithEmailAndPassword(
//                     usernamecontroller.text,
//                     emailcontroller.text,
//                     passwordcontroller.text,