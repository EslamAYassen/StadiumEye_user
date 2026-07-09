import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/networking/endpoints.dart';
import '../models/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDataModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      debugPrint(dio.options.headers['Authorization']);
      final response = await dio.get(UserEndpoints.myProfile);

      if (response.statusCode == 200) {
        return HomeDataModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to load home data',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      return UnauthorizedException(
        e.response?.data['message'] ??
            'Your session has expired. Please sign in again.',
      );
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NoInternetException();
    }

    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return ServerException(message);
    }

    return const ServerException('An unexpected error occurred');
  }
}
