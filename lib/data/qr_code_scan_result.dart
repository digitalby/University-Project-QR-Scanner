import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class QRCodeScanResult implements CodeScanResult {
  @override
  Uint8List data;

  @override
  String resultTitle;
}