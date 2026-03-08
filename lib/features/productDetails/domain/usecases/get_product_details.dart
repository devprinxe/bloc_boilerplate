import 'package:dartz/dartz.dart';
import 'package:fintech/core/error/failures.dart';
import 'package:fintech/features/productDetails/domain/entities/product_details.dart';
import 'package:fintech/features/productDetails/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProductDetails {
  final ProductDetailsRepository repository;

  GetProductDetails(this.repository);

  Future<Either<Failure, ProductDetailsEntities>> call({required String productId}) async {
    return await repository.getProductDetails(productId: productId);
  }
}
