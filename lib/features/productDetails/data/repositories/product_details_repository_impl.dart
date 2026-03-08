import 'package:dartz/dartz.dart';
import 'package:fintech/core/error/failures.dart';
import 'package:fintech/features/productDetails/data/datasources/product_details_datasource.dart';
import 'package:fintech/features/productDetails/domain/entities/product_details.dart';
import 'package:fintech/features/productDetails/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepository)
class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsDatasource datasource;

  ProductDetailsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProductDetailsEntities>> getProductDetails({required String productId}) async {
    try {
      final result = await datasource.getProductDetails(productId: productId);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
