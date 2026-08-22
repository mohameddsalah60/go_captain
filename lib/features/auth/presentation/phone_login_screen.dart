import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_captin/features/auth/presentation/widgets/phone_auth_body.dart';

import '../../../core/services/get_it_service.dart';
import '../../../core/utils/app_colors.dart';
import '../domin/repos/auth_repo.dart';
import 'cubit/phone_auth_cubit.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneAuthCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: const PhoneAuthBody(),
      ),
    );
  }
}
