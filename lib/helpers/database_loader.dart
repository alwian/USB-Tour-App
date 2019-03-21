import 'dart:typed_data';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLoader {
  static Future<bool> load(BuildContext context, String dbName) async {
    String dbsPath = await getDatabasesPath();
    String pathToCopyTo = join(dbsPath, dbName);
    if(! await File(pathToCopyTo).exists()) {
      ByteData dbFile = await DefaultAssetBundle.of(context).load(join('assets/databases/', dbName));
      List<int> bytes = dbFile.buffer.asUint8List(dbFile.offsetInBytes, dbFile.lengthInBytes);
      await File(pathToCopyTo).writeAsBytes(bytes);
    }
    return true;
  }
}