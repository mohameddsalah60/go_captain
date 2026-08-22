import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.visibleBackButton = false});
  final bool visibleBackButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: visibleBackButton
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (visibleBackButton)
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.sp,
                color: AppColors.black,
              ),
              splashRadius: 18,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          Image.asset(AppImages.goCaptain, height: 34.h, fit: BoxFit.contain),
          if (visibleBackButton)
            SizedBox(width: 32.w), // Placeholder to balance the back button
        ],
      ),
    );
  }
}
