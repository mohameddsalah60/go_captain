import 'package:flutter/material.dart';

import 'sign_in_screen.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return const SignInScreen();
  }
}
