// failures.dart

abstract class Failure {
  final String message;

  const Failure(this.message);
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server error"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache error"]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = "Authentication failed"]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "Unknown error"]);
}
