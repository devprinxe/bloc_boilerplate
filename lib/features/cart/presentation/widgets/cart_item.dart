import 'package:fintech/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/custom_network_image.dart';

class CartItem extends StatelessWidget {
  final CartItemModel product;
  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CustomNetworkImage(url: product.image, width: 80, height: 80, fit: BoxFit.fill, borderRadius: BorderRadius.circular(10)),
          Expanded(
            child: Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
