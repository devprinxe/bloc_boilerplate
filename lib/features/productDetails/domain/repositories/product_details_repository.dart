import 'package:dartz/dartz.dart';
import 'package:fintech/core/error/failures.dart';
import 'package:fintech/features/productDetails/domain/entities/product_details.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsEntities>> getProductDetails({required String productId});
}
