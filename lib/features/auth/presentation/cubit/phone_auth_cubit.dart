import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/repos/auth_repo.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit(this.authRepo) : super(const PhoneAuthState());

  final AuthRepo authRepo;

  Future<void> sendOtp() async {
    emit(
      state.copyWith(
        status: PhoneAuthStatus.loading,
        isValid: false,
        errorMessage: null,
      ),
    );

    final result = await authRepo.sendOtp(phone: '+2${state.phoneNumber}');

    result.fold(
      (failure) {
        final friendlyMessage = _friendlyFailureMessage(failure.errorMessage);
        log('Failed to send OTP: ${failure.errorMessage}');
        emit(
          state.copyWith(
            status: PhoneAuthStatus.failure,
            isValid: false,
            errorMessage: friendlyMessage,
          ),
        );
      },
      (_) {
        log('OTP sent successfully to ${state.phoneNumber}');
        emit(
          state.copyWith(
            status: PhoneAuthStatus.success,
            isValid: true,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void onPhoneChanged(String value) {
    var sanitizedPhone = value.replaceAll(RegExp(r'\D'), '');

    if (sanitizedPhone.length == 10 &&
        ['1', '2', '5'].contains(sanitizedPhone.substring(0, 1))) {
      sanitizedPhone = '0$sanitizedPhone';
    }

    final validationMessage = _validatePhone(sanitizedPhone);

    emit(
      state.copyWith(
        phoneNumber: sanitizedPhone,
        isValid: validationMessage == null,
        errorMessage: validationMessage,
        status: PhoneAuthStatus.initial,
      ),
    );
  }

  Future<void> submit() async {
    final validationMessage = _validatePhone(state.phoneNumber);
    final isValid = validationMessage == null;

    if (!isValid) {
      emit(
        state.copyWith(
          isValid: false,
          errorMessage: validationMessage,
          status: PhoneAuthStatus.failure,
        ),
      );
      return;
    }

    await sendOtp();
  }

  static String _friendlyFailureMessage(String message) {
    final normalized = message
        .replaceAll('Exception: ', '')
        .replaceAll('SocketException', '')
        .replaceAll('DioException', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (normalized.isEmpty) {
      return 'تعذّر إرسال رمز التحقق. حاول مرة أخرى.';
    }

    if (normalized.contains('Socket') || normalized.contains('network')) {
      return 'لا يوجد اتصال بالإنترنت. تحقق من الشبكة ثم حاول مرة أخرى.';
    }

    if (normalized.contains('timeout')) {
      return 'انتهت مهلة الاتصال. حاول مرة أخرى بعد قليل.';
    }

    return 'تعذّر إرسال رمز التحقق. حاول مرة أخرى.';
  }

  static String? _validatePhone(String phoneNumber) {
    final sanitizedPhone = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (sanitizedPhone.isEmpty) {
      return 'رقم الهاتف مطلوب.';
    }

    if (sanitizedPhone.length != 11) {
      return 'رقم الهاتف غير صالح. أدخل رقم موبايل مصري صحيح.';
    }

    const validPrefixes = ['010', '011', '012', '015'];
    if (!validPrefixes.any(sanitizedPhone.startsWith)) {
      return 'رقم الهاتف غير صالح. أدخل رقم موبايل مصري صحيح.';
    }

    return null;
  }
}
