import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_event.dart';
import 'package:fintech/features/productDetails/presentation/bloc/related_product_bloc/related_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_related_product.dart';

@injectable
class RelatedProductBloc extends Bloc<RelatedProductEvent, RelatedProductState> {
  final GetRelatedProduct _getRelatedProduct;

  RelatedProductBloc(this._getRelatedProduct) : super(RelatedProductLoading()) {
    on<FetchRelatedProductEvent>((event, emit) async {
      emit(RelatedProductLoading());
      final result = await _getRelatedProduct.call(productId: event.productId);
      result.fold(
        (failure) {
          emit(RelatedProductInitial());
        },
        (products) {
          emit(RelatedProductLoaded(relatedProducts: products));
        },
      );
    });
  }
}
