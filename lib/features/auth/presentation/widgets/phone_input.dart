import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({super.key, this.errorText, this.onSaved});

  final String? errorText;
  final void Function(String)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.wheitSecondary,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: errorText != null ? AppColors.error : AppColors.greyBorder,
              width: 1.2,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🇪🇬', style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 8.w),
                    Text(
                      '+20',
                      style: AppTextStyles.w700s14.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextFormField(
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onChanged: onSaved,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.w600s16.copyWith(color: AppColors.black),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: 'رقم الموبايل',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: AppTextStyles.w500s15.copyWith(
                      color: AppColors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              errorText!,
              style: AppTextStyles.w500s11.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ],
    );
  }
}
