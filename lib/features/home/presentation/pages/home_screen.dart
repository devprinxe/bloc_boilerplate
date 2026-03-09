import 'package:fintech/core/router/app_routes.dart';
import 'package:fintech/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/blocs/network_checker/network_checker_bloc.dart';
import '../../../../shared/blocs/network_checker/network_checker_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Handle auto-retry on reconnection
        BlocListener<NetworkCheckerBloc, NetworkCheckerState>(
          listenWhen: (prev, curr) => prev is InternetDisconnected && curr is InternetConnected,
          listener: (context, _) {
            final state = context.read<HomeBloc>().state;
            if (state is HomeErrorState) {
              context.read<HomeBloc>().add(LoadProducts());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: RefreshIndicator(
          onRefresh: () async => context.read<HomeBloc>().add(LoadProducts()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
                slivers: [
                  if (state is HomeLoadingState) const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),

                  if (state is HomeErrorState) SliverFillRemaining(child: Center(child: Text(state.message))),

                  if (state is HomeLoadedState)
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.9),
                        delegate: SliverChildBuilderDelegate((context, i) {
                          final product = state.products[i];
                          return InkWell(
                            onTap: () {
                              context.push(AppRoutes.productDetailsRoute(product.id.toString()));
                            },
                            child: ProductCard(product: product),
                          );
                        }, childCount: state.products.length),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
