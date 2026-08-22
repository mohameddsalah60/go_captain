part of 'phone_auth_cubit.dart';

enum PhoneAuthStatus { initial, loading, success, failure }

class PhoneAuthState {
  const PhoneAuthState({
    this.phoneNumber = '',
    this.isValid = false,
    this.errorMessage,
    this.status = PhoneAuthStatus.initial,
  });

  final String phoneNumber;
  final bool isValid;
  final String? errorMessage;
  final PhoneAuthStatus status;

  static const Object _sentinel = Object();

  PhoneAuthState copyWith({
    String? phoneNumber,
    bool? isValid,
    Object? errorMessage = _sentinel,
    PhoneAuthStatus? status,
  }) {
    return PhoneAuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
      status: status ?? this.status,
    );
  }
}
