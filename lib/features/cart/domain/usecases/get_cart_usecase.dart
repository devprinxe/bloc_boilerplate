import 'package:dartz/dartz.dart';
import 'package:fintech/features/cart/data/models/cart_item_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/i_cart_repository.dart';

@injectable
class GetCartUseCase {
  final ICartRepository _repository;

  GetCartUseCase(this._repository);

  Future<Either<Failure, List<CartItemModel>>> call() async {
    return await _repository.getCartProducts();
  }
}
