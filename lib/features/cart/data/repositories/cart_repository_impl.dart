import 'package:dartz/dartz.dart';
import 'package:fintech/features/cart/data/models/cart_item_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/i_cart_repository.dart';

@Injectable(as: ICartRepository)
class CartRepositoryImpl implements ICartRepository {
  @override
  Future<Either<Failure, List<CartItemModel>>> getCartProducts() async {
    try {
      final response = <CartItemModel>[];
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
