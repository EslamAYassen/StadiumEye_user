import 'package:dio/dio.dart';

import '../../../../core/networking/endpoints.dart';
import '../models/cities_response_model.dart';
import '../models/countries_response_model.dart';
import '../models/reports_response_model.dart';
import '../models/stadiums_response_model.dart';
import '../models/ticket_model.dart';

abstract class ReportsRemoteDataSource {
  Future<ReportsResponseModel> getMyReports({
    int page = 1,
    int limit = 20,
    String? status,
  });
  Future<StadiumsResponseModel> getStadiums();
  Future<CountriesResponseModel> getCountries();
  Future<CitiesResponseModel> getCities();
  Future<TicketModel> createReport({
    required String stadiumId,
    required String area,
    // required String? ticketType,
    required String observations,
    // required String? challenges,
    // required String? lessonsLearned,
    required bool mode,
    // String? modelType,
    String? locationLink,
    List<String>? ticketVideosPaths,
    List<String>? ticketImagesPaths,
    List<String>? ticketVoicesPaths,
  });
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final Dio dio;

  ReportsRemoteDataSourceImpl(this.dio);

  @override
  Future<ReportsResponseModel> getMyReports({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'limit': limit,
        if (status != null && status.isNotEmpty) 'status': status,
      };

      final response = await dio.get(
        ReportEndpoints.myReports,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return ReportsResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load reports');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<StadiumsResponseModel> getStadiums() async {
    try {
      final response = await dio.get(StadiumEndpoints.stadiums);

      if (response.statusCode == 200) {
        return StadiumsResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load stadiums');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<TicketModel> createReport({
    required String stadiumId,
    required String area,
    // required String? ticketType,
    required String observations,
    // required String? challenges,
    // required String? lessonsLearned,
    required bool mode,
    // String? modelType,
    String? locationLink,
    List<String>? ticketVideosPaths,
    List<String>? ticketImagesPaths,
    List<String>? ticketVoicesPaths,
  }) async {
    try {
      // Create FormData for multipart request
      final formData = FormData.fromMap({
        'stadium': stadiumId,
        'area': area,
        // 'ticketType': ticketType,
        'observations': observations,
        // 'challenges': challenges,
        // 'lessonsLearned': lessonsLearned,
        'mode': mode ? 'ai' : 'manual',
        // if (modelType != null) 'modelType': modelType,
        if (locationLink != null) 'locationLink': locationLink,
      });

      // Add video files
      if (ticketVideosPaths != null && ticketVideosPaths.isNotEmpty) {
        for (var videoPath in ticketVideosPaths) {
          formData.files.add(
            MapEntry(
              'ticketVideos',
              await MultipartFile.fromFile(
                videoPath,
                filename: videoPath.split('/').last,
              ),
            ),
          );
        }
      }

      // Add image files
      if (ticketImagesPaths != null && ticketImagesPaths.isNotEmpty) {
        for (var imagePath in ticketImagesPaths) {
          formData.files.add(
            MapEntry(
              'ticketImages',
              await MultipartFile.fromFile(
                imagePath,
                filename: imagePath.split('/').last,
              ),
            ),
          );
        }
      }

      // Add voice files
      if (ticketVoicesPaths != null && ticketVoicesPaths.isNotEmpty) {
        for (var voicePath in ticketVoicesPaths) {
          formData.files.add(
            MapEntry(
              'ticketVoices',
              await MultipartFile.fromFile(
                voicePath,
                filename: voicePath.split('/').last,
              ),
            ),
          );
        }
      }

      final response = await dio.post(
        options: Options(sendTimeout: const Duration(hours: 1)),
        ReportEndpoints.createReport,
        data: formData,
      );

      if (response.data['status'] == 'success') {
        return TicketModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to create report');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<CountriesResponseModel> getCountries() async {
    try {
      final response = await dio.get(LocationEndpoints.countries);

      if (response.statusCode == 200) {
        return CountriesResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load countries');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<CitiesResponseModel> getCities() async {
    try {
      final response = await dio.get(LocationEndpoints.cities);

      if (response.statusCode == 200) {
        return CitiesResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load cities');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
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
