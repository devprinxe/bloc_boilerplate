// The BLoC
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'network_checker_event.dart';
import 'network_checker_state.dart';

@injectable
class NetworkCheckerBloc extends Bloc<NetworkCheckerEvent, NetworkCheckerState> {
  StreamSubscription? _subscription;

  NetworkCheckerBloc() : super(InternetInitial()) {
    _subscription = InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.connected) {
        add(InternetConnectedEvent());
      } else {
        add(InternetDisconnectedEvent());
      }
    });
    // 2. Handle events
    on<InternetConnectedEvent>((event, emit) => emit(InternetConnected()));
    on<InternetDisconnectedEvent>((event, emit) => emit(InternetDisconnected()));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
