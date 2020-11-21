import 'dart:typed_data';

import 'package:flutter/services.dart';

abstract class CodeScanResult {
  int id;
  DateTime date;
  Uint8List data;
  String resultTitle;
}