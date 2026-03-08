import 'package:equatable/equatable.dart';

import '../../domain/entities/product_details.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntities productDetails;

  const ProductDetailsLoaded({required this.productDetails});
  @override
  List<Object> get props => [productDetails];
}
