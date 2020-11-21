import 'dart:typed_data';

import 'package:flutter/services.dart';

abstract class CodeScanResult {
  DateTime date;
  Uint8List data;
  String resultTitle;
}