import 'package:fintech/core/router/app_routes.dart';
import 'package:fintech/features/splash/presentation/pages/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/presentation/pages/cart_screen_provider.dart';
import '../../features/home/presentation/pages/home_screen_provider.dart';
import '../../features/main/presentation/pages/main_wrapper_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreenProvider();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapperScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) {
                  return const HomeScreenProvider();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                builder: (context, state) {
                  return const CartScreenProvider();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
