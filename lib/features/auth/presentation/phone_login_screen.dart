import 'package:flutter/material.dart';
import 'package:go_captin/features/auth/presentation/widgets/phone_auth_body.dart';

import '../../../core/utils/app_colors.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white, body: PhoneAuthBody());
  }
}
