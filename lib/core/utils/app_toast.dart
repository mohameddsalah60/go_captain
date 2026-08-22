import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    required bool isSuccess,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: isSuccess ? AppColors.success : AppColors.error,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          content: Row(
            children: [
              Icon(
                isSuccess
                    ? Icons.check_circle_outline_rounded
                    : Icons.error_outline_rounded,
                color: AppColors.white,
                size: 18.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.w600s14.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
