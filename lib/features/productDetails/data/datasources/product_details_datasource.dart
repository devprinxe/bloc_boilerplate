import 'package:fintech/core/constants/api_endpoints.dart';
import 'package:fintech/features/home/data/models/product_model.dart';
import 'package:fintech/features/productDetails/data/models/product_details_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';

abstract class ProductDetailsDatasource {
  Future<ProductDetailsModel> getProductDetails({required String productId});
  Future<List<ProductModel>> getRelatedProducts();
}

@Injectable(as: ProductDetailsDatasource)
class ProductDetailsDatasourceImpl implements ProductDetailsDatasource {
  final ApiClient _apiClient;

  ProductDetailsDatasourceImpl(this._apiClient);

  @override
  Future<ProductDetailsModel> getProductDetails({required String productId}) async {
    final response = await _apiClient.get(ApiEndpoints.productDetails(id: productId));
    return ProductDetailsModel.fromJson(response.data);
  }

  @override
  Future<List<ProductModel>> getRelatedProducts() async {
    final response = await _apiClient.get(ApiEndpoints.products);
    return (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
