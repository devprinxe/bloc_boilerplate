import 'package:equatable/equatable.dart';

sealed class RelatedProductEvent extends Equatable {
  const RelatedProductEvent();

  @override
  List<Object> get props => [];
}

class FetchRelatedProductEvent extends RelatedProductEvent {
  final String productId;

  const FetchRelatedProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
