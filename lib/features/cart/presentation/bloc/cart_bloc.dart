import 'package:fintech/features/cart/data/models/cart_item_model.dart';
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
    on<AddToCart>(addToCart);
  }

  Future<void> loadCartProducts(LoadCartProducts event, Emitter<CartState> emit) async {
    emit(CartLoadedState([]));
  }

  Future<void> addToCart(AddToCart event, Emitter<CartState> emit) async {
    final cartItems = <CartItemModel>[];
    if (state is CartLoadedState) {
      final previousItems = (state as CartLoadedState).products;
      cartItems.addAll(previousItems);
    }
    cartItems.add(CartItemModel.fromProductEntity(event.product, 2));
    emit(CartLoadedState(cartItems));
  }
}
