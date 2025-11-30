//TODO: Implement Dio method

import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/report_model.dart';
import 'report_remote_ds.dart';

class ReportRemoteDSImpl implements ReportRemoteDS {
  final String baseUrl;
  final String? token;

  ReportRemoteDSImpl({required this.baseUrl, this.token});

  // Map<String, String> get _headers => {
  //   "Content-Type": "application/json",
  //   if (token != null) "Authorization": "Bearer $token",
  // };

  @override
  Future<void> createReport(ReportModel report) async {
    // final url = Uri.parse("$baseUrl/reports");
    // final dio = Dio();
    // final response = await dio.post(
    //   url,
    //   headers: _headers,
    //   body: jsonEncode(report.toJson()),
    // );

    // if (response.statusCode != 201 && response.statusCode != 200) {
    //   throw Exception(
    //     "Failed to create report: ${response.statusCode} - ${response.body}",
    //   );
    // }
  }

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
