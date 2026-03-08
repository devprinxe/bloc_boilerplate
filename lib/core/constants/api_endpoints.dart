class ApiEndpoints {
  // Fallback base url
  static const String baseUrl = 'https://api.escuelajs.co/api';

  // Api Versioning
  static const String _v1 = '/v1';

  // Auth
  static const String login = '$_v1/auth/login';
  static const String profile = '$_v1/auth/profile';

  // Products
  static const String products = '$_v1/products';
  static String productDetails({required String id}) => '$_v1/products/$id';
}
