import 'package:fintech/core/network/custom_network_image.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_bloc.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../home/presentation/widgets/product_card.dart';
import '../bloc/product_details_bloc.dart';
import '../bloc/product_details_state.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProductDetails')),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomNetworkImage(url: state.productDetails.productImages[0], width: double.infinity, height: 300, fit: BoxFit.contain),
                  Text(state.productDetails.title),
                  Text(state.productDetails.description),
                  BlocBuilder<RelatedProductBloc, RelatedProductState>(
                    builder: (context, state) {
                      if (state is RelatedProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is RelatedProductLoaded) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
                          itemCount: state.relatedProducts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return InkWell(
                              onTap: () {
                                context.push(AppRoutes.productDetailsRoute(state.relatedProducts[i].id.toString()));
                              },
                              child: ProductCard(product: state.relatedProducts[i]),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
