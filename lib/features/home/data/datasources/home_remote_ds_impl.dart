import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

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
        throw Exception(response.data['message'] ?? 'Failed to load home data');
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
