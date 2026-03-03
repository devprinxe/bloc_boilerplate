import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc_observer.dart';
import '../injections/injection.dart';

class Bootstrap {
  static Future<void> init(FutureOr<Widget> Function() builder) async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = AppBlocObserver();

    configureDependencies();

    FlutterError.onError = (details) {
      debugPrint(details.exceptionAsString());
    };

    runApp(await builder());
  }
}
