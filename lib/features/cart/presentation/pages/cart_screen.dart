import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCartProducts());
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoadedState) {
            return ListView.builder(
              key: ValueKey('cart_list_${state.products.length}_${DateTime.now().millisecondsSinceEpoch}'),
              itemCount: state.products.length,
              itemBuilder: (_, i) {
                return CartItem(product: state.products[i]);
              },
            );
          } else if (state is CartErrorState) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
