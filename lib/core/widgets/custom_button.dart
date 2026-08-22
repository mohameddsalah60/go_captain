import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textStyle,
    this.colors,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final List<Color>? colors;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                colors ??
                [
                  AppColors.mainBlue,
                  AppColors.mainBlue.withValues(alpha: 0.50),
                ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18.w,
                      height: 18.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      text,
                      style:
                          textStyle ??
                          AppTextStyles.w700s18.copyWith(color: Colors.white),
                    ),
                  ],
                )
              : Text(
                  text,
                  style:
                      textStyle ??
                      AppTextStyles.w700s18.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
