import 'package:fintech/core/injections/injection.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_bloc.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_event.dart';
import 'package:fintech/features/productDetails/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_details_bloc.dart';
import '../bloc/product_details_event.dart';

class ProductDetailsPageProvider extends StatelessWidget {
  final String productId;
  const ProductDetailsPageProvider({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProductDetailsBloc>()..add(FetchProductDetailsEvent(productId))),
        BlocProvider(create: (context) => getIt<RelatedProductBloc>()..add(FetchRelatedProductEvent(productId))),
      ],
      child: ProductDetailsPage(),
    );
  }
}
