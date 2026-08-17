import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/onboarding_page_data.dart';
import '../../cubit/onbording_cubit.dart';
import 'onboarding_page_widget.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: context.read<OnbordingCubit>().pageController,
        itemCount: OnboardingPageData.pages.length,
        onPageChanged: context.read<OnbordingCubit>().onPageChanged,
        itemBuilder: (context, index) {
          return OnboardingPageWidget(
            data: OnboardingPageData.pages[index],
            pageIndex: index,
            currentPage: context.read<OnbordingCubit>().currentPage,
          );
        },
      ),
    );
  }
}
