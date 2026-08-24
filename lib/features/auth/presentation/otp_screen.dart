import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_captin/core/services/get_it_service.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import 'cubit/otp_cubit.dart';
import '../domin/repos/auth_repo.dart';
import 'widgets/auth_header.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});

  static const String routeName = '/otp';

  final String phone;

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

  String get _otpCode =>
      _controllers.map((controller) => controller.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(getIt<AuthRepo>()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: OtpScreenBody(
            controllers: _controllers,
            focusNodes: _focusNodes,
            otpCode: _otpCode,
            phone: widget.phone,
          ),
        ),
      ),
    );
  }
}

class OtpScreenBody extends StatefulWidget {
  const OtpScreenBody({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.otpCode,
    required this.phone,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final String otpCode;
  final String phone;

  @override
  State<OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<OtpScreenBody> {
  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.controllers.length - 1) {
        FocusScope.of(context).requestFocus(widget.focusNodes[index + 1]);
      }
    } else if (index > 0) {
      FocusScope.of(context).requestFocus(widget.focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                style: AppTextStyles.w400s14.copyWith(color: AppColors.grey),
                children: [
                  const TextSpan(text: 'تم إرسال الرمز إلى '),
                  TextSpan(
                    text: widget.phone,
                    style: AppTextStyles.w600s14.copyWith(
                      color: AppColors.mainBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 28.h),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
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
                    controller: widget.controllers[index],
                    focusNode: widget.focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      _onDigitChanged(value, index);
                      final currentCode = widget.controllers
                          .map((c) => c.text)
                          .join();
                      context.read<OtpCubit>().onCodeChanged(currentCode);
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
          ),
          SizedBox(height: 28.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لم تستلم الرمز؟',
                style: AppTextStyles.w400s14.copyWith(color: AppColors.grey),
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
          BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state.status == OtpStatus.success) {
                // You can navigate or show success
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'تأكيد',
                onPressed: state.isValid && state.status != OtpStatus.loading
                    ? () => context.read<OtpCubit>().verify(
                        phone: widget.phone.replaceAll(' ', ''),
                      )
                    : null,
                isLoading: state.status == OtpStatus.loading,
              );
            },
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
