import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_captin/features/auth/presentation/widgets/auth_header.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/auth_button.dart';
import '../widgets/phone_input.dart';
import '../widgets/terms_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            AuthHeader(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42.r),
                  topRight: Radius.circular(42.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'أهلاً بيك في Go Captain 👋',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.w700s26,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'اكتب رقم موبايلك وخلينا نبدأ مشوارك.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        height: 1.7,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    const PhoneInput(),
                    SizedBox(height: 24.h),
                    AuthButton(),
                    SizedBox(height: 24.h),
                    const Center(child: TermsText()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
