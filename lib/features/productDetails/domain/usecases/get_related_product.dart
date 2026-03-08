import 'package:dartz/dartz.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/product_details_repository.dart';

@LazySingleton()
class GetRelatedProduct {
  final ProductDetailsRepository repository;

  GetRelatedProduct(this.repository);

  Future<Either<Failure, List<ProductEntities>>> call({required String productId}) async {
    return await repository.getRelatedProducts(productId: productId);
  }
}
