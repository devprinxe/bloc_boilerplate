import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/custom_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductEntities product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          CustomNetworkImage(
            url: product.productImages[0],
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
