import 'package:dartz/dartz.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/i_home_repository.dart';

@injectable
class GetProductsUseCase {
  final IHomeRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<Failure, List<ProductEntities>>> call() async {
    return await _repository.getProducts();
  }
}
