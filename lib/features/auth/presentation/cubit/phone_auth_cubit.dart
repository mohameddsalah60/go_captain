import 'package:flutter_bloc/flutter_bloc.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(const PhoneAuthState());

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
      ),
    );
  }

  void submit() {
    final validationMessage = _validatePhone(state.phoneNumber);
    final isValid = validationMessage == null;

    emit(state.copyWith(isValid: isValid, errorMessage: validationMessage));
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
