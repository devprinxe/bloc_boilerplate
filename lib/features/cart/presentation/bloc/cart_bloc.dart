import 'package:fintech/core/storage/isar_storage.dart';
import 'package:fintech/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_local_storage.dart';
import '../../data/models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final AppLocalStorage _storage;
  final IsarStorage _isarStorage;
  final GetCartUseCase _getCartProductsUseCase;

  CartBloc(this._storage, this._isarStorage, this._getCartProductsUseCase) : super(CartInitialState()) {
    on<LoadCartProducts>(loadCartProducts);
    on<AddToCart>(addToCart);
    on<ClearCartProducts>(clearCartProducts);
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

  Future<void> addToCart(AddToCart event, Emitter<CartState> emit) async {
    CartItemModel item = CartItemModel.fromProductEntity(event.product, 1);

    // 1. Check if the product is already there and get it
    final existingItem = await _isarStorage.isProductInCart(item.productId);

    if (existingItem) {
      // 2. If it exists, increment the quantity of the EXISTING record
      item.quantity++;
      await _isarStorage.put<CartItemModel>(item);
    } else {
      await _isarStorage.put<CartItemModel>(item);
    }

    // 4. Refresh the list from the database to get the latest data
    final updatedList = await _isarStorage.getAll<CartItemModel>();

    // 5. Emit the updated state (triggering the BlocBuilder/BlocSelector)
    emit(CartLoadedState(updatedList));
  }

  Future<void> clearCartProducts(ClearCartProducts event, Emitter<CartState> emit) async {
    await _isarStorage.clear<CartItemModel>();
    emit(CartLoadedState([]));
  }
}
