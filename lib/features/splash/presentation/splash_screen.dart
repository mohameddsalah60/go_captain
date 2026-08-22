import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_captin/features/onboarding/presentation/views/onboarding_view.dart';

import '../../../constants.dart';
import '../../../core/services/shared_preferences_singletone.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../auth/presentation/phone_login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  static const _symbolDuration = Duration(milliseconds: 700);
  static const _wordmarkDelay = Duration(milliseconds: 400);
  static const _wordmarkDuration = Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    final logoWidth = 228.w;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZoomIn(
                duration: _symbolDuration,
                from: 1,
                curve: Curves.elasticOut,
                child: _SplashSymbol(logoWidth: logoWidth),
              ),
              FadeInUp(
                delay: _wordmarkDelay,
                duration: _wordmarkDuration,
                from: 24,
                curve: Curves.easeOutCubic,
                onFinish: (_) => _excuteNaviagtion(context),
                child: _SplashWordmark(logoWidth: logoWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _excuteNaviagtion(BuildContext context) {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    log(isOnBoardingViewSeen.toString());

    if (isOnBoardingViewSeen) {
      Navigator.pushReplacementNamed(context, PhoneLoginScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnboardingView.routeName);
    }
  }
}

abstract final class _SplashLogoLayout {
  static const logoAspect = 898 / 1024;
  static const symbolFraction = 0.62;
}

class _SplashSymbol extends StatelessWidget {
  const _SplashSymbol({required this.logoWidth});

  final double logoWidth;

  @override
  Widget build(BuildContext context) {
    final logoHeight = logoWidth * _SplashLogoLayout.logoAspect;
    final symbolHeight = logoHeight * _SplashLogoLayout.symbolFraction;

    return SizedBox(
      width: logoWidth,
      height: symbolHeight,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _SplashLogoLayout.symbolFraction,
          child: Image.asset(
            AppImages.appLogo,
            width: logoWidth,
            height: logoHeight,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

class _SplashWordmark extends StatelessWidget {
  const _SplashWordmark({required this.logoWidth});

  final double logoWidth;

  @override
  Widget build(BuildContext context) {
    final logoHeight = logoWidth * _SplashLogoLayout.logoAspect;
    final symbolHeight = logoHeight * _SplashLogoLayout.symbolFraction;
    final wordmarkHeight = logoHeight - symbolHeight;

    return SizedBox(
      width: logoWidth,
      height: wordmarkHeight,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: wordmarkHeight / logoHeight,
          child: Transform.translate(
            offset: Offset(0, -symbolHeight),
            child: Image.asset(
              AppImages.appLogo,
              width: logoWidth,
              height: logoHeight,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}
