import 'package:cartup/features/splash/presentation/bloc/splash_event.dart';
import 'package:cartup/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_local_storage.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppLocalStorage _storage;
  SplashBloc(this._storage) : super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2)); // Logo visibility

      bool isFirstTime = _storage.isFirstTime();

      if (isFirstTime) {
        _storage.setFirstTimeComplete();
        emit(NavigateToOnboarding());
      } else if (_storage.getToken() != null) {
        emit(NavigateToHome());
      } else {
        emit(NavigateToWelcome());
      }
    });
  }
}
