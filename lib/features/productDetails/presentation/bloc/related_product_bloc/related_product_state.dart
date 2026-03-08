import 'package:equatable/equatable.dart';

import '../../../../home/domain/entities/product_entities.dart';

sealed class RelatedProductState extends Equatable {
  const RelatedProductState();

  @override
  List<Object> get props => [];
}

final class RelatedProductInitial extends RelatedProductState {}

final class RelatedProductLoading extends RelatedProductState {}

final class RelatedProductLoaded extends RelatedProductState {
  final List<ProductEntities> relatedProducts;

  const RelatedProductLoaded({required this.relatedProducts});
  @override
  List<Object> get props => [relatedProducts];
}
