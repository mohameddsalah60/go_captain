import 'package:flutter_test/flutter_test.dart';
import 'package:go_captin/features/auth/presentation/cubit/phone_auth_cubit.dart';

void main() {
  group('PhoneAuthCubit', () {
    test('accepts valid Egyptian mobile numbers', () {
      final cubit = PhoneAuthCubit();

      cubit.onPhoneChanged('01012345678');

      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('rejects invalid or short phone numbers', () {
      final cubit = PhoneAuthCubit();

      cubit.onPhoneChanged('010123');

      expect(cubit.state.isValid, isFalse);
      expect(
        cubit.state.errorMessage,
        'رقم الهاتف غير صالح. أدخل رقم موبايل مصري صحيح.',
      );
    });

    test('clears error message after input becomes valid', () {
      final cubit = PhoneAuthCubit();

      cubit.onPhoneChanged('010123');
      cubit.onPhoneChanged('01012345678');

      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('adds leading zero automatically when missing', () {
      final cubit = PhoneAuthCubit();

      cubit.onPhoneChanged('1234567890');

      expect(cubit.state.phoneNumber, '01234567890');
      expect(cubit.state.isValid, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });
  });
}
