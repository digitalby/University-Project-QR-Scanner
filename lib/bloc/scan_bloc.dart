import 'dart:async';
import 'dart:convert';

import 'package:university_project_qr_scanner/bloc/bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:university_project_qr_scanner/bloc/throttling.dart';

class ScanBloc implements Bloc {
  CodeScanResult _result;
  CodeScanResult get scanResult => _result;

  final _resultController = StreamController<CodeScanResult>();
  final _throttling = Throttling(duration: Duration(seconds: 1));
  final _throttlingSameQRCode = Throttling(duration: Duration(seconds: 5));

  Stream<CodeScanResult> get resultStream => _resultController.stream;

  void processScanResult(CodeScanResult result) {
    _throttling.throttle(() {
      if (_result?.data.toString() == result?.data.toString()) {
        _throttlingSameQRCode.throttle(() => _sinkResult(result));
      } else {
        _sinkResult(result);
      }
    });
  }

  void _sinkResult(CodeScanResult result) {
    _result = result;
    _resultController.sink.add(result);
  }

  void launchURLScanResult(CodeScanResult result) async {
    if (result == null) {
      return;
    }
    final url = utf8.decoder.convert(result.data);
    if (await canLaunch(url)) {
      await launch(url).whenComplete(() => print("complete"));
    }
  }

  @override
  void dispose() {
    _resultController.close();
  }
}