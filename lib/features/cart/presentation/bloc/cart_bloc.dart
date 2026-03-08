import 'package:fintech/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_local_storage.dart';
import 'cart_event.dart';
import 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final AppLocalStorage _storage;
  final GetCartUseCase _getCartProductsUseCase;

  CartBloc(this._storage, this._getCartProductsUseCase) : super(CartInitialState()) {
    on<LoadCartProducts>(loadCartProducts);
  }

  Future<void> loadCartProducts(LoadCartProducts event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    final result = await _getCartProductsUseCase();
    result.fold(
      (failure) {
        emit(CartErrorState(failure.message));
      },
      (products) {
        emit(CartLoadedState(products));
      },
    );
  }
}
