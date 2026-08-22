import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_toast.dart';
import '../cubit/phone_auth_cubit.dart';
import '../otp_screen.dart';
import 'auth_form_section.dart';
import 'auth_header.dart';
import 'auth_welcome_message.dart';

class PhoneAuthBody extends StatelessWidget {
  const PhoneAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state.status == PhoneAuthStatus.failure &&
            state.errorMessage != null) {
          AppToast.show(
            context,
            message: state.errorMessage!,
            isSuccess: false,
          );
        }

        if (state.status == PhoneAuthStatus.success) {
          AppToast.show(
            context,
            message: 'تم إرسال رمز التحقق بنجاح.',
            isSuccess: true,
          );
          Navigator.pushNamed(context, OtpScreen.routeName);
        }
      },
      child: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
        builder: (context, state) {
          final cubit = context.read<PhoneAuthCubit>();

          return SafeArea(
            child: SingleChildScrollView(
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
                          const AuthWelcomeMessage(),
                          SizedBox(height: 22.h),
                          AuthFormSection(
                            errorText: state.errorMessage,
                            isValid: state.isValid,
                            isLoading: state.status == PhoneAuthStatus.loading,
                            onPhoneChanged: cubit.onPhoneChanged,
                            onSubmit: cubit.submit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
