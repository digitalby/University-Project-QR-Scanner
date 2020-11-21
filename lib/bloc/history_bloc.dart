import 'dart:async';

import 'package:university_project_qr_scanner/bloc/bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';
import 'package:university_project_qr_scanner/data/db.dart';
import 'package:university_project_qr_scanner/data/qr_code_scan_result.dart';

class HistoryBloc implements Bloc {
  var _results = <CodeScanResult>[];
  List<CodeScanResult> get results => _results;

  final _controller = StreamController<List<CodeScanResult>>.broadcast();
  Stream<List<CodeScanResult>> get historyStream => _controller.stream;

  void fetchResults() async {
    final results = await _queryResults();
    _controller.sink.add(results);
  }

  Future<List<CodeScanResult>> _queryResults() {
    return DatabaseProvider.shared.queryCodeScanResultsFromDatabase();
  }

  void addQRResult(QRCodeScanResult result) async {
    await DatabaseProvider.shared.addQRCodeScanResultToDatabase(result);
    fetchResults();
  }

  void removeResult(QRCodeScanResult result) async {
    await DatabaseProvider.shared.removeQRCodeScanResultFromDatabase(result);
    fetchResults();
  }

  void removeAllResults() async {
    await DatabaseProvider.shared.removeAllQRCodeScanResultsFromDatabase();
    fetchResults();
  }

  @override
  void dispose() {
    _controller.close();
  }

}