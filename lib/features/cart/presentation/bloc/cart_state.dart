import 'package:equatable/equatable.dart';
import 'package:fintech/features/cart/data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItemModel> products;

  const CartLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

class CartErrorState extends CartState {
  final String message;

  const CartErrorState(this.message);
  @override
  List<Object> get props => [message];
}
