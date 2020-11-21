import 'dart:convert';
import 'dart:typed_data';

import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class QRCodeScanResult implements CodeScanResult {
  @override
  DateTime date;

  @override
  Uint8List data;

  @override
  String resultTitle;

  @override
  String toString() {
    if (data == null) {
      return super.toString();
    }
    return utf8.decoder.convert(data);
  }
}