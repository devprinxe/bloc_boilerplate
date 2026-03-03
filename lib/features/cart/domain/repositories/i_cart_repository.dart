import 'package:dartz/dartz.dart';
import 'package:fintech/features/cart/data/models/cart_item_model.dart';

import '../../../../core/error/failures.dart';

abstract class ICartRepository {
  Future<Either<Failure, List<CartItemModel>>> getCartProducts();
}
