import 'package:dartz/dartz.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';

import '../../../../core/error/failures.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<ProductEntities>>> getProducts();
}
