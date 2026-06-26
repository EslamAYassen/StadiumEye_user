import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/matches_res.dart';
import '../models/matches_model.dart';

abstract class MatchesRemoteDataSource {
  Future<ParantMatchesRes> getMatches({
    String? date,
    String? league,
    String? season,
    String? team,
    String? timezone,
  });
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  Dio dio;
  MatchesRemoteDataSourceImpl(this.dio);

  @override
  Future<MatchResponseModel> getMatches({
    String? date,
    String? league,
    String? season,
    String? team,
    String? timezone,
  }) async {
    try {
      final apiKey = dotenv.env['API_KEY'] ?? '';
      final baseUrl = "https://v3.football.api-sports.io";

      if (apiKey.isEmpty || baseUrl.isEmpty) {
        throw Exception('API_KEY not found in .env file');
      }

      final Map<String, dynamic> queryParameters = {};
      if (date != null) queryParameters['date'] = date;
      if (league != null) queryParameters['league'] = league;
      if (season != null) queryParameters['season'] = season;
      if (team != null) queryParameters['team'] = team;
      if (timezone != null) queryParameters['timezone'] = timezone;

      final response = await dio.get(
        '$baseUrl/fixtures',
        queryParameters: queryParameters,
        options: Options(headers: {'x-rapidapi-key': apiKey}),
      );

      if (response.statusCode == 200 && response.data['errors'].isEmpty) {
        return MatchResponseModel.fromJson(response.data);
      } else if (response.statusCode == 200 &&
          response.data['errors'].isNotEmpty) {
        throw Exception('API Error: ${response.data['errors'][0]}');
      } else {
        throw Exception('Failed to load matches: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected Error: $e');
    }
  }

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
