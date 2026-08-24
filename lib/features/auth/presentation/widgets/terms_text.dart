import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/extinctions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../terms_screen.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.w400s14.copyWith(
          color: AppColors.grey,
          fontFamily: 'Cairo',
        ),
        children: [
          const TextSpan(text: 'بإكمالك، أنت موافق على '),
          TextSpan(
            text: 'شروط الاستخدام',
            style: AppTextStyles.w600s14.copyWith(color: AppColors.mainBlue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(TermsScreen.routeName);
              },
          ),
          const TextSpan(text: ' و '),
          TextSpan(
            text: 'سياسة الخصوصية',
            style: AppTextStyles.w600s14.copyWith(color: AppColors.mainBlue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(TermsScreen.routeName);
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
