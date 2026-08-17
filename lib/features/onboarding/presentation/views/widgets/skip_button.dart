import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_captin/core/utils/app_images.dart';

import '../../../data/onboarding_page_data.dart';
import '../../cubit/onbording_cubit.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible:
                context.read<OnbordingCubit>().currentPage !=
                OnboardingPageData.pages.length - 1,
            replacement: SizedBox(height: 60.h),
            child: TextButton(
              onPressed: () {
                context.read<OnbordingCubit>().pageController.jumpToPage(
                  OnboardingPageData.pages.length - 1,
                );
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const Spacer(),
          Image.asset(AppImages.goCaptain, width: 130.w),
        ],
      ),
    );
  }
}
