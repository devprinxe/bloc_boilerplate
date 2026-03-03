import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<Response<T>> request<T>({required String path, required String method, dynamic data, bool isFormData = false, Map<String, dynamic>? query, Map<String, dynamic>? headers, ResponseType responseType = ResponseType.json, CancelToken? cancelToken, ProgressCallback? onSendProgress}) async {
    try {
      dynamic finalData = data;
      if (isFormData && data is Map<String, dynamic>) {
        finalData = FormData.fromMap(data);
      }

      return await _dio.request<T>(
        path,
        data: finalData,
        queryParameters: query,
        onSendProgress: onSendProgress,
        options: Options(method: method, headers: headers, responseType: responseType),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      // 1. Convert Dio error to ApiException
      final apiException = _getApiException(e);
      // 2. Map to Failure and throw
      throw _mapExceptionToFailure(apiException);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  // --- Convenience Methods ---

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) => request<T>(path: path, method: 'GET', query: query);

  Future<Response<T>> post<T>(String path, {dynamic data, bool isFormData = false}) => request<T>(path: path, method: 'POST', data: data, isFormData: isFormData);

  Future<Response<T>> put<T>(String path, {dynamic data, bool isFormData = false}) => request<T>(path: path, method: 'PUT', data: data, isFormData: isFormData);

  Future<Response<T>> patch<T>(String path, {dynamic data, bool isFormData = false}) => request<T>(path: path, method: 'PATCH', data: data, isFormData: isFormData);

  Future<Response<T>> delete<T>(String path) => request<T>(path: path, method: 'DELETE');

  // --- Private Error Logic ---

  ApiException _getApiException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
      return ApiException(message: "Connection timed out");
    }

    // Extract message from server response if available
    final message = e.response?.data?['message'] ?? "An unexpected error occurred";
    return ApiException(message: message, statusCode: e.response?.statusCode);
  }

  Failure _mapExceptionToFailure(ApiException e) {
    if (e.statusCode == 401 || e.statusCode == 403) {
      return AuthFailure(message: e.message);
    } else if (e.statusCode != null && e.statusCode! >= 500) {
      return ServerFailure(message: e.message);
    } else if (e.message.contains("timed out") || e.statusCode == null) {
      return NetworkFailure(message: e.message);
    }
    return ServerFailure(message: e.message);
  }
}
