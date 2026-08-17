import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/onboarding_page_data.dart';
import '../cubit/onbording_cubit.dart';
import 'widgets/onbording_page_indicator.dart';
import 'widgets/page_view_builder.dart';
import 'widgets/skip_button.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  static const String routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnbordingCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: const OnboardingBody(),
      ),
    );
  }
}

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnbordingCubit, OnbordingState>(
      builder: (context, state) {
        final cubit = context.read<OnbordingCubit>();
        return SafeArea(
          child: Column(
            children: [
              SkipButton(),
              PageViewBuilder(),

              Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(28.w, 0, 28.w, 32.h),
                  child: Column(
                    children: [
                      OnBordingPageIndicator(
                        count: OnboardingPageData.pages.length,
                        currentIndex: cubit.currentPage,
                      ),

                      SizedBox(height: 28.h),

                      CustomButton(
                        colors:
                            cubit.currentPage ==
                                OnboardingPageData.pages.length - 1
                            ? [
                                AppColors.brandYellow,
                                AppColors.brandYellow.withValues(alpha: .45),
                              ]
                            : [
                                AppColors.mainBlue,
                                AppColors.mainBlue.withValues(alpha: 0.55),
                              ],
                        text:
                            cubit.currentPage ==
                                OnboardingPageData.pages.length - 1
                            ? 'ابدأ الآن 🚀'
                            : 'التالي',
                        onPressed: () {
                          cubit.onNext(
                            context,
                            OnboardingPageData.pages.length,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
