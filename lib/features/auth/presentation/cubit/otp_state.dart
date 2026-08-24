part of 'otp_cubit.dart';

enum OtpStatus { initial, loading, success, failure }

class OtpState {
  const OtpState({
    this.code = '',
    this.isValid = false,
    this.errorMessage,
    this.status = OtpStatus.initial,
  });

  final String code;
  final bool isValid;
  final String? errorMessage;
  final OtpStatus status;

  static const Object _sentinel = Object();

  OtpState copyWith({
    String? code,
    bool? isValid,
    Object? errorMessage = _sentinel,
    OtpStatus? status,
  }) {
    return OtpState(
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
      status: status ?? this.status,
    );
  }
}
