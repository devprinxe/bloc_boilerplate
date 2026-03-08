import 'package:fintech/core/network/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return Column(
              children: [CustomNetworkImage(url: state.productDetails.productImages[0], width: double.infinity, height: 300, fit: BoxFit.contain)],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
