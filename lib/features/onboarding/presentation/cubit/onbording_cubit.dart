import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extinctions.dart';
import '../../../../core/routing/app_routes.dart';

part 'onbording_state.dart';

class OnbordingCubit extends Cubit<OnbordingState> {
  OnbordingCubit() : super(OnbordingInitial());

  final PageController pageController = PageController();

  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    emit(OnbordingPageChanged(index));
  }

  void goToLogin(BuildContext context) {
    context.pushReplacementNamed(AppRoutes.login);
  }

  void onNext(BuildContext context, int pageCount) {
    if (currentPage < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      goToLogin(context);
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
