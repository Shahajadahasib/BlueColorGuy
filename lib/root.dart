import 'package:bluecolorguy/auth/auth.dart';
import 'package:bluecolorguy/pages/homeview.dart';
import 'package:bluecolorguy/auth/registration.dart';

import 'package:bluecolorguy/auth/signin.dart';
import 'package:bluecolorguy/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;
          return user == null
              ? const SignIn()
              : const Homeviews(
                  // email: user.email.toString(),
                  // uid: user.uid.toString(),
                  );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
