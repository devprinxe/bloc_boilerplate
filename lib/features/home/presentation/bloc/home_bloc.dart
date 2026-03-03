import 'package:fintech/features/home/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_local_storage.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppLocalStorage _storage;
  final GetProductsUseCase _getProductsUseCase;

  HomeBloc(this._storage, this._getProductsUseCase) : super(HomeInitialState()) {
    on<LoadProducts>((event, emit) async {
      emit(HomeLoadingState());
      final result = await _getProductsUseCase();
      result.fold(
        (failure) {
          emit(HomeErrorState(failure.message));
        },
        (products) {
          emit(HomeLoadedState(products));
        },
      );
    });
  }
}
