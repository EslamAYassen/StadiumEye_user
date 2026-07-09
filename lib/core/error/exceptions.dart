/// Typed exceptions thrown by remote data sources so repositories can map
/// each one to the matching [Failure] subtype (see `core/error/failures.dart`)
/// instead of collapsing every network/server problem into a single
/// generic message. This is what lets the UI tell apart "no internet",
/// "server problem", and "your session expired" instead of showing the
/// same generic error for all three.
library;

/// A generic server-side problem (5xx, malformed response, etc).
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error']);

  @override
  String toString() => message;
}

/// Thrown when the device has no usable connection, or the request timed
/// out / couldn't reach the server at all.
class NoInternetException implements Exception {
  final String message;
  const NoInternetException([this.message = 'No internet connection']);

  @override
  String toString() => message;
}

/// Thrown when the server responds with 401 Unauthorized, meaning the
/// cached access token is missing, invalid, or expired.
class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([
    this.message = 'Your session has expired. Please sign in again.',
  ]);

  @override
  String toString() => message;
}
