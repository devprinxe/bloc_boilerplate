import 'package:equatable/equatable.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartProducts extends CartEvent {}

class ClearCartProducts extends CartEvent {}

class AddToCart extends CartEvent {
  final ProductEntities product;
  const AddToCart({required this.product});

  @override
  List<Object> get props => [product];
}
