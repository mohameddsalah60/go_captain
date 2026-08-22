import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth_button.dart';
import 'phone_input.dart';
import 'terms_text.dart';

class AuthFormSection extends StatelessWidget {
  const AuthFormSection({
    super.key,
    required this.errorText,
    required this.isValid,
    required this.onPhoneChanged,
    required this.onSubmit,
  });

  final String? errorText;
  final bool isValid;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhoneInput(errorText: errorText, onSaved: onPhoneChanged),
        SizedBox(height: 24.h),
        AuthButton(isEnabled: isValid, onPressed: onSubmit),
        SizedBox(height: 24.h),
        const Center(child: TermsText()),
      ],
    );
  }
}
