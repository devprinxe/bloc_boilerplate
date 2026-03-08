import 'package:fintech/features/productDetails/domain/usecases/get_product_details.dart';
import 'package:fintech/features/productDetails/presentation/bloc/product_details_event.dart';
import 'package:fintech/features/productDetails/presentation/bloc/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetails _getProductDetails;

  ProductDetailsBloc(this._getProductDetails) : super(ProductDetailsLoading()) {
    on<FetchProductDetailsEvent>((event, emit) async {
      emit(ProductDetailsLoading());
      final result = await _getProductDetails.call(productId: event.productId);
      result.fold(
        (failure) {
          emit(ProductDetailsInitial());
        },
        (productDetails) {
          emit(ProductDetailsLoaded(productDetails: productDetails));
        },
      );
    });
  }
}
