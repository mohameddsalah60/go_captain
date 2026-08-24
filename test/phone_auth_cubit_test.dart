import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_captin/core/errors/failures.dart';
import 'package:go_captin/features/auth/domin/repos/auth_repo.dart';
import 'package:go_captin/features/auth/presentation/cubit/phone_auth_cubit.dart';

class FakeAuthRepo implements AuthRepo {
  final Either<Failure, dynamic> result;

  FakeAuthRepo({required this.result});

  @override
  Future<Either<Failure, dynamic>> sendOtp({required String phone}) async =>
      result;

  @override
  Future<Either<Failure, dynamic>> verifyOtp({
    required String phone,
    required String code,
  }) async => result;
}

void main() {
  group('PhoneAuthCubit', () {
    test('accepts valid Egyptian mobile numbers', () {
      final cubit = PhoneAuthCubit(FakeAuthRepo(result: const Right('ok')));

      cubit.onPhoneChanged('01012345678');

      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('rejects invalid or short phone numbers', () {
      final cubit = PhoneAuthCubit(FakeAuthRepo(result: const Right('ok')));

      cubit.onPhoneChanged('010123');

      expect(cubit.state.isValid, isFalse);
      expect(
        cubit.state.errorMessage,
        'رقم الهاتف غير صالح. أدخل رقم موبايل مصري صحيح.',
      );
    });

    test('clears error message after input becomes valid', () {
      final cubit = PhoneAuthCubit(FakeAuthRepo(result: const Right('ok')));

      cubit.onPhoneChanged('010123');
      cubit.onPhoneChanged('01012345678');

      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('adds leading zero automatically when missing', () {
      final cubit = PhoneAuthCubit(FakeAuthRepo(result: const Right('ok')));

      cubit.onPhoneChanged('1234567890');

      expect(cubit.state.phoneNumber, '01234567890');
      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('enters loading state before success', () async {
      final cubit = PhoneAuthCubit(FakeAuthRepo(result: const Right('ok')));

      cubit.onPhoneChanged('01012345678');
      await cubit.submit();

      expect(cubit.state.status, PhoneAuthStatus.success);
      expect(cubit.state.errorMessage, isNull);
    });

    test('sets failure state when otp request fails', () async {
      final cubit = PhoneAuthCubit(
        FakeAuthRepo(result: Left(ServerFailure('SocketException'))),
      );

      cubit.onPhoneChanged('01012345678');
      await cubit.submit();

      expect(cubit.state.status, PhoneAuthStatus.failure);
      expect(cubit.state.errorMessage, isNotNull);
    });
  });
}
