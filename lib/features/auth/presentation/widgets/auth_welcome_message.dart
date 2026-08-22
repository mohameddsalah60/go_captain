import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class AuthWelcomeMessage extends StatelessWidget {
  const AuthWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أهلاً بيك في Go Captain 👋',
          textAlign: TextAlign.right,
          style: AppTextStyles.w700s26.copyWith(color: AppColors.black),
        ),
        SizedBox(height: 12.h),
        Text(
          'اكتب رقم موبايلك وخلينا نبدأ مشوارك.',
          textAlign: TextAlign.right,
          style: AppTextStyles.w500s14.copyWith(
            color: AppColors.grey,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}
