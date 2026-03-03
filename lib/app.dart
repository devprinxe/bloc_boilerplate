import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRouter.router, theme: ThemeData(useMaterial3: true));
  }
}
