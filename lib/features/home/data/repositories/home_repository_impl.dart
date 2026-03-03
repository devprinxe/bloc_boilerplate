import 'package:dartz/dartz.dart';
import 'package:fintech/core/constants/api_endpoints.dart';
import 'package:fintech/features/home/domain/entities/product_entities.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../models/product_model.dart';

@Injectable(as: IHomeRepository)
class HomeRepositoryImpl implements IHomeRepository {
  final ApiClient _apiClient;

  HomeRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, List<ProductEntities>>> getProducts() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.products);
      final List data = response.data;
      final products = data.map((json) => ProductModel.fromJson(json).toEntity()).toList();
      return Right(products);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
