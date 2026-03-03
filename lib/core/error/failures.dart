abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure({String message = "A server error occurred"}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = "No internet connection"}) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure({String message = "Unauthorized access"}) : super(message);
}
