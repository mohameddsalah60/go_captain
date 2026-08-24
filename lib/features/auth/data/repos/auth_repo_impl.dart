import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_phone_service.dart';
import '../../domin/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthPhoneService authPhoneService;

  AuthRepoImpl({required this.authPhoneService});

  @override
  Future<Either<Failure, dynamic>> sendOtp({required String phone}) async {
    try {
      final response = await authPhoneService.sendOtp(phone: phone);
      log("auth repo response :$response");
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await authPhoneService.verifyOtp(
        phone: phone,
        code: code,
      );
      log("verify repo response :$response");
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
