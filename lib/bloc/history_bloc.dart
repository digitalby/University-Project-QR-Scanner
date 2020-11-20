import 'dart:async';
import 'dart:developer';

import 'package:university_project_qr_scanner/bloc/bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class HistoryBloc implements Bloc {
  var _results = <CodeScanResult>[];
  List<CodeScanResult> get results => _results;

  final _controller = StreamController<List<CodeScanResult>>.broadcast();
  Stream<List<CodeScanResult>> get favoritesStream => _controller.stream;

  void fetchResults() {
    final results = <CodeScanResult>[];
    _controller.sink.add(results);
  }

  void addResult(CodeScanResult result) {
    log("Add result $result");
    _controller.sink.add(results);
  }

  void removeResult(CodeScanResult result) {
    log("Remove result $result");
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}