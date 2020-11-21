import 'dart:async';
import 'dart:developer';

import 'package:university_project_qr_scanner/bloc/bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class HistoryBloc implements Bloc {
  var _results = <CodeScanResult>[];
  List<CodeScanResult> get results => _results;

  final _controller = StreamController<List<CodeScanResult>>.broadcast();
  Stream<List<CodeScanResult>> get historyStream => _controller.stream;

  void fetchResults() {
    if (_results == null) {
      _initResults();
    }
    _controller.sink.add(results);
  }

  void addResult(CodeScanResult result) {
    if (_results == null) {
      _initResults();
    }
    _results.add(result);
    _controller.sink.add(results);
  }

  void removeResult(CodeScanResult result) {
    _results.remove(result);
    _controller.sink.add(results);
  }

  void removeAllResults() {
    _results = [];
    _controller.sink.add(results);
  }

  void _initResults() {
    final results = <CodeScanResult>[];
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }

}