part of 'phone_auth_cubit.dart';

class PhoneAuthState {
  const PhoneAuthState({
    this.phoneNumber = '',
    this.isValid = false,
    this.errorMessage,
  });

  final String phoneNumber;
  final bool isValid;
  final String? errorMessage;

  static const Object _sentinel = Object();

  PhoneAuthState copyWith({
    String? phoneNumber,
    bool? isValid,
    Object? errorMessage = _sentinel,
  }) {
    return PhoneAuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
