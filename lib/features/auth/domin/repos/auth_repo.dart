import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> sendOtp({required String phone});
  Future<Either<Failure, dynamic>> verifyOtp({
    required String phone,
    required String code,
  });
}
