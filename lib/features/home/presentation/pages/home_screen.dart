import 'package:fintech/core/router/app_routes.dart';
import 'package:fintech/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadedState) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
              itemCount: state.products.length,
              itemBuilder: (_, i) {
                return InkWell(
                  onTap: () {
                    context.push(AppRoutes.productDetailsRoute(state.products[i].id.toString()));
                  },
                  child: ProductCard(product: state.products[i]),
                );
              },
            );
          } else if (state is HomeErrorState) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
