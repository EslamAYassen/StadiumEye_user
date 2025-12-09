//TODO: Implement Dio method

import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/report_model.dart';
import 'report_remote_ds.dart';

class ReportRemoteDSImpl implements ReportRemoteDS {
  ReportRemoteDSImpl();

  @override
  Future<void> createReport(ReportModel report) async {}

  @override
  Future<List<ReportModel>> getMyReports() async {}
}
