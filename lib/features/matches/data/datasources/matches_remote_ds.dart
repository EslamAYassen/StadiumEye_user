import 'package:dio/dio.dart';

import '../../domain/entities/matches_res.dart';

abstract class MatchesRemoteDataSource {
  Future<ParantMatchesRes> getMatches();
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  @override
  Future<ParantMatchesRes> getMatches() {
    //TODO: implement actual API call
    return Future.value(ParantMatchesRes(errors: [], results: 0, response: []));
  }

  // ignore: unused_element
  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return Exception(message);
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('An unexpected error occurred');
    }
  }
}
