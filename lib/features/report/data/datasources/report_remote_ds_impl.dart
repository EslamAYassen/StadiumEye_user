//TODO: Implement Dio method

import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/report_model.dart';
import 'report_remote_ds.dart';

class ReportRemoteDSImpl implements ReportRemoteDS {
  final String baseUrl;
  final String? token;

  ReportRemoteDSImpl({required this.baseUrl, this.token});

  @override
  Future<void> createReport(ReportModel report) async {}

  @override
  Future<List<ReportModel>> getMyReports() async {
    final url = "$baseUrl/reports/my";
    final dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to fetch reports: ${response.statusCode} - ${response.data}",
      );
    }

    final List decoded = jsonDecode(response.data);

    return decoded
        .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
