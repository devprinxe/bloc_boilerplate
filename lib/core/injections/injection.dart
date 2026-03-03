import 'package:dio/dio.dart';
import 'package:fintech/core/config/env_config.dart';
import 'package:fintech/core/injections/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/cart/data/models/cart_item_model.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => getIt.init(environment: EnvConfig.environment);

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Isar> get isar async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([
      CartItemModelSchema, // as your app grows
    ], directory: dir.path);
  }

  @Environment('prod')
  @lazySingleton
  Dio get dio => _setupDio(EnvConfig.baseUrl, includeLogs: false);

  @Environment('dev')
  @lazySingleton
  Dio get mockDio => _setupDio(EnvConfig.baseUrl, includeLogs: true);

  Dio _setupDio(String baseUrl, {required bool includeLogs}) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10)));

    if (includeLogs) {
      dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90));
    }
    return dio;
  }
}
