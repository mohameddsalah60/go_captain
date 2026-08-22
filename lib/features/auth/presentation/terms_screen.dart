import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import 'widgets/auth_header.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const String routeName = '/terms';

  @override
  Widget build(BuildContext context) {
    final termsText = '''
بإستخدامك لتطبيق Go Captain، فإنك توافق على الالتزام بالشروط التالية:

1. يلتزم المستخدم بتوفير بيانات صحيحة ومحدثة عند التسجيل.
2. يحظر استخدام التطبيق في أي أغراض غير قانونية أو مخالفة للنظام.
3. تحتفظ الشركة بحق تحديث الخدمة أو إيقافها مؤقتاً أو نهائياً عند الضرورة.
4. يتم التعامل مع البيانات الشخصية وفق سياسة الخصوصية المعتمدة في التطبيق.
5. يلتزم المستخدم بعدم نشر محتوى مسيء أو مضلل أو ينتهك حقوق الآخرين.
6. التطبيق يقدم خدماته على أساس "كما هي" مع عدم تحمل المسؤولية عن أي خسائر غير مباشرة.

نؤكد أن استخدامك للتطبيق يعني موافقتك على هذه البنود، ويحق لنا تعديلها من وقت لآخر.
''';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: AuthHeader(visibleBackButton: true),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الشروط والأحكام',
                      style: AppTextStyles.w700s24.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      termsText,
                      style: AppTextStyles.w400s14.copyWith(
                        color: AppColors.grey,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.right,
                    ),
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
