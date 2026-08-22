import 'package:dio/dio.dart';

import 'dio_handle_exception.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioException) {
    return ServerFailure(
      DioExceptionHandler.handleException(dioException),
    );
  }
}

class PermissionFailure extends Failure {
  PermissionFailure(super.errorMessage);
}

class LocationServiceFailure extends Failure {
  LocationServiceFailure(super.errorMessage);
}
