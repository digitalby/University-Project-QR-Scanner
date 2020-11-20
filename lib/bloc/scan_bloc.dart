import 'dart:async';

import 'package:university_project_qr_scanner/bloc/bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class ScanBloc implements Bloc {
  CodeScanResult _result;
  CodeScanResult get scanResult => _result;

  final _resultController = StreamController<CodeScanResult>();

  Stream<CodeScanResult> get resultStream => _resultController.stream;

  void processScanResult(CodeScanResult result) {
    _result = result;
    _resultController.sink.add(result);
  }

  @override
  void dispose() {
    _resultController.close();
  }
}