import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';
import 'package:university_project_qr_scanner/data/qr_code_scan_result.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider shared = DatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    String path = join(await getDatabasesPath(), "qr_history.db");
    return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE QRCodeScanResult ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "resultTitle TEXT,"
            "date TEXT,"
            "data BLOB"
            ")");
      },
    );
  }

  Future<List<QRCodeScanResult>> queryQRCodeScanResultsFromDatabase() async {
    final db = await database;
    var response = await db.query("QRCodeScanResult");
    List<QRCodeScanResult> list = response.map((x)
    => QRCodeScanResult.fromMap(x)).toList();
    return list;
  }

  Future<List<CodeScanResult>> queryCodeScanResultsFromDatabase() async
  => await queryQRCodeScanResultsFromDatabase();

  addQRCodeScanResultToDatabase(QRCodeScanResult result) async {
    final db = await database;
    return await db.insert(
      "QRCodeScanResult",
      result.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  removeQRCodeScanResultFromDatabase(QRCodeScanResult result) async {
    final db = await database;
    return await db.delete("QRCodeScanResult", where: "id = ?", whereArgs: [result.id]);
  }

  removeAllQRCodeScanResultsFromDatabase() async {
    final db = await database;
    return await db.delete("QRCodeScanResult");
  }
}