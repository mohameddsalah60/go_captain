import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import 'widgets/auth_header.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  static const String routeName = '/otp';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _controllers.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  String get _otpCode =>
      _controllers.map((controller) => controller.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              const AuthHeader(visibleBackButton: true),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'رمز التحقق',
                  style: AppTextStyles.w700s24.copyWith(color: AppColors.black),
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.w400s14.copyWith(
                      color: AppColors.grey,
                    ),
                    children: [
                      const TextSpan(text: 'تم إرسال الرمز إلى '),
                      TextSpan(
                        text: '+966 500 000 000',
                        style: AppTextStyles.w600s14.copyWith(
                          color: AppColors.mainBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 42.w,
                    height: 75.h,
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      autofocus: index == 0,
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        _onDigitChanged(value, index);
                        setState(() {});
                      },
                      style: AppTextStyles.w700s20.copyWith(
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.wheitDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.mainBlue,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم تستلم الرمز؟',
                    style: AppTextStyles.w400s14.copyWith(
                      color: AppColors.grey,
                    ),
                  ),

                  SizedBox(width: 8.w),
                  Text(
                    'إعادة إرسال الرمز',
                    style: AppTextStyles.w600s14.copyWith(
                      color: AppColors.mainBlue,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'تأكيد',
                onPressed: _otpCode.length == 6 ? () {} : null,
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
