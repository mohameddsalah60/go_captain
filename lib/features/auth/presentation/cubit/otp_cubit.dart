import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/repos/auth_repo.dart';
import '../../../../core/utils/error_mapper.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.authRepo) : super(const OtpState());

  final AuthRepo authRepo;

  void onCodeChanged(String code) {
    final sanitized = code.replaceAll(RegExp(r'\s+'), '');
    emit(
      state.copyWith(
        code: sanitized,
        isValid: sanitized.length == 6,
        errorMessage: null,
        status: OtpStatus.initial,
      ),
    );
  }

  Future<void> verify({required String phone}) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: OtpStatus.loading, errorMessage: null));

    final result = await authRepo.verifyOtp(phone: phone, code: state.code);
    log('code: ${state.code}');

    result.fold(
      (failure) {
        final friendly = ErrorMapper.friendlyMessage(failure);
        log('Verify failed: ${failure.errorMessage}');
        emit(state.copyWith(status: OtpStatus.failure, errorMessage: friendly));
      },
      (_) {
        log('OTP verified');
        emit(state.copyWith(status: OtpStatus.success));
      },
    );
  }

  // Error mapping delegated to ErrorMapper
}
