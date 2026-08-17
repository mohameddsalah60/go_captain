import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          height: 1.8,
        ),
        children: [
          const TextSpan(text: 'بإكمالك، أنت موافق على '),
          TextSpan(
            text: 'شروط الاستخدام',
            style: TextStyle(
              color: AppColors.mainBlue,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' و '),
          TextSpan(
            text: 'سياسة الخصوصية',
            style: TextStyle(
              color: AppColors.mainBlue,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
