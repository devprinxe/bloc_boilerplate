import 'package:fintech/core/constants/api_endpoints.dart';
import 'package:fintech/features/productDetails/data/models/product_details_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';

abstract class ProductDetailsDatasource {
  Future<ProductDetailsModel> getProductDetails({required String productId});
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
}
