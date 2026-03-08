import 'package:dartz/dartz.dart';
import 'package:fintech/core/error/failures.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:fintech/features/productDetails/domain/entities/product_details.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsEntities>> getProductDetails({required String productId});
  Future<Either<Failure, List<ProductEntities>>> getRelatedProducts({required String productId});
}
