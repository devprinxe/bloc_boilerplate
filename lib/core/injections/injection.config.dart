// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cartup/core/injections/injection.dart' as _i772;
import 'package:cartup/core/network/api_client.dart' as _i901;
import 'package:cartup/core/storage/app_local_storage.dart' as _i250;
import 'package:cartup/features/splash/presentation/bloc/splash_bloc.dart'
    as _i966;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i250.AppLocalStorage>(
      () => _i250.AppLocalStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.mockDio,
      registerFor: {_dev},
    );
    gh.factory<_i966.SplashBloc>(
      () => _i966.SplashBloc(gh<_i250.AppLocalStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio, registerFor: {_prod});
    gh.lazySingleton<_i901.ApiClient>(() => _i901.ApiClient(gh<_i361.Dio>()));
    return this;
  }
}

class _$RegisterModule extends _i772.RegisterModule {}
