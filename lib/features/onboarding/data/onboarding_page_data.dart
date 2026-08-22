import 'package:flutter/material.dart';

import '../../../../core/utils/app_illustrations.dart';
import '../presentation/views/widgets/onboarding_illustration.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustrationAsset,
  });

  final String title;
  final String description;
  final String illustrationAsset;

  Widget buildIllustration() =>
      OnboardingIllustration(assetPath: illustrationAsset);

  static final List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: "جاهز للمشوار؟ يلا بينا!",
      description: "كل اللي عليك تحدد وجهتك، وإحنا نسهّل عليك الباقي.",
      illustrationAsset: AppIllustrations.requestRide,
    ),
    OnboardingPageData(
      title: 'المشوار على مزاجك',
      description: "شوف تفاصيل الرحلة والكابتن قبل ما تأكد مشوارك.",
      illustrationAsset: AppIllustrations.captainArriving,
    ),
    OnboardingPageData(
      title: 'اركب وخلّي الباقي علينا',
      description: 'تابع رحلتك من أول الطريق لحد ما توصل.',
      illustrationAsset: AppIllustrations.rideTracking,
    ),
  ];
}
