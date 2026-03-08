import 'package:fintech/core/network/custom_network_image.dart';
import 'package:fintech/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fintech/features/cart/presentation/bloc/cart_event.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_bloc.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../home/presentation/widgets/product_card.dart';
import '../bloc/product_details_bloc.dart';
import '../bloc/product_details_state.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDetails'),
        actions: [
          BlocSelector<CartBloc, CartState, int>(
            selector: (state) {
              if (state is CartLoadedState) {
                return state.products.length;
              }
              return 0;
            },
            builder: (context, itemCount) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Badge(label: Text('$itemCount'), isLabelVisible: itemCount > 0, child: const Icon(Icons.shopping_cart_outlined)),
              );
            },
          ),
        ],
      ),
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
                  Row(
                    children: [
                      Expanded(
                        child: BlocListener<CartBloc, CartState>(
                          listener: (context, state) {
                            if (state is CartLoadedState) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added to cart")));
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddToCart(
                                  product: ProductEntities(id: state.productDetails.id, title: state.productDetails.title, description: state.productDetails.description, price: state.productDetails.price, categoryName: state.productDetails.categoryName, categoryImage: state.productDetails.categoryImage, productImages: state.productDetails.productImages),
                                ),
                              );
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(onPressed: () {}, child: const Text('Buy Now')),
                      ),
                    ],
                  ),
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
