import 'package:fintech/features/cart/presentation/bloc/cart_event.dart';
import 'package:fintech/shared/netowork_checker/network_checker_bloc.dart';
import 'package:fintech/shared/netowork_checker/network_checker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injections/injection.dart';
import 'core/router/app_router.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (context) => getIt<CartBloc>()..add(LoadCartProducts())),
        BlocProvider<NetworkCheckerBloc>(create: (context) => getIt<NetworkCheckerBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData(useMaterial3: true),
        builder: (context, child) {
          return BlocListener<NetworkCheckerBloc, NetworkCheckerState>(
            listenWhen: (previous, current) {
              if (current is InternetDisconnected) return true;
              if (previous is InternetDisconnected && current is InternetConnected) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              if (state is InternetDisconnected) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Internet Connection!')));
              } else if (state is InternetConnected) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Internet Connection!')));
              }
            },
            child: child!, // This is your router's widget tree
          );
        },
      ),
    );
  }
}
