import 'package:fintech/core/router/app_routes.dart';
import 'package:fintech/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/netowork_checker/network_checker_bloc.dart';
import '../../../../shared/netowork_checker/network_checker_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BlocListener<NetworkCheckerBloc, NetworkCheckerState>(
          listenWhen: (previous, current) {
            if (previous is InternetDisconnected && current is InternetConnected) return true;
            return false;
          },
          listener: (context, networkState) {
            if (state is HomeErrorState) context.read<HomeBloc>().add(LoadProducts());
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Products')),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadProducts());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is HomeLoadingState) CircularProgressIndicator(),
                    if (state is HomeLoadedState)
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, i) {
                          return InkWell(
                            onTap: () {
                              context.push(AppRoutes.productDetailsRoute(state.products[i].id.toString()));
                            },
                            child: ProductCard(product: state.products[i]),
                          );
                        },
                      ),
                    if (state is HomeErrorState) Center(child: Text(state.message)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
