import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/report_model.dart';
import 'report_remote_ds.dart';

class ReportRemoteDSImpl implements ReportRemoteDS {
  final String baseUrl;
  final String? token;

  ReportRemoteDSImpl({required this.baseUrl, this.token});

  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    if (token != null) "Authorization": "Bearer $token",
  };

  @override
  Future<void> createReport(ReportModel report) async {
    final url = Uri.parse("$baseUrl/reports");

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(
        "Failed to create report: ${response.statusCode} - ${response.body}",
      );
    }
  }

  @override
  Future<List<ReportModel>> getMyReports() async {
    final url = Uri.parse("$baseUrl/reports/my");

    final response = await http.get(url, headers: _headers);

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to fetch reports: ${response.statusCode} - ${response.body}",
      );
    }

    final List decoded = jsonDecode(response.body);

    return decoded
        .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
