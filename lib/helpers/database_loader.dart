import 'dart:typed_data';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLoader {
  static Future<bool> _load(BuildContext context, String dbsPath, String dbName) async {
    String pathToCopyTo = join(dbsPath, dbName);
    if(! await File(pathToCopyTo).exists()) {
      ByteData dbFile = await DefaultAssetBundle.of(context).load(join('assets/databases/', dbName));
      List<int> bytes = dbFile.buffer.asUint8List(dbFile.offsetInBytes, dbFile.lengthInBytes);
      await File(pathToCopyTo).writeAsBytes(bytes);
    } else {
      await File(pathToCopyTo).delete();
      _load(context, dbsPath, dbName);
    }
    return true;
  }

  static Future<bool> loadSingular(BuildContext context, String dbName) async {
    String dbsPath = await getDatabasesPath();
    return await _load(context, dbsPath, dbName);
  }

  static Future<bool> loadAll(BuildContext context, List<String> dbNames) async {
    String dbsPath = await getDatabasesPath();
    for(String dbName in dbNames) {
      await _load(context, dbsPath, dbName);
    }
    return true;
  }
}