import 'package:fintech/core/constants/api_endpoints.dart';

class EnvConfig {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: ApiEndpoints.baseUrl);
}
