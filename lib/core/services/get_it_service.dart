import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domin/repos/auth_repo.dart';
import 'api_service.dart';
import 'auth_phone_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  getIt.registerSingleton<AuthPhoneService>(
    AuthPhoneService(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authPhoneService: getIt<AuthPhoneService>()),
  );
}
