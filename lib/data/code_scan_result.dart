import 'dart:typed_data';

import 'package:flutter/services.dart';

abstract class CodeScanResult {
  Uint8List data;
  String resultTitle;
}