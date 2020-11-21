import 'dart:convert';
import 'dart:typed_data';

import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class QRCodeScanResult implements CodeScanResult {
  @override
  int id;

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

  QRCodeScanResult({this.id, this.date, this.data, this.resultTitle});

  factory QRCodeScanResult.fromMap(Map<String, dynamic> map) => QRCodeScanResult(
    id: map["id"],
    date: DateTime.parse(map["date"]),
    data: map['data'],
    resultTitle: map['resultTitle'],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date.toIso8601String(),
    "data": data,
    "resultTitle": resultTitle,
  };
}