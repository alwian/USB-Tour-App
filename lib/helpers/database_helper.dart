/// Author Alex Anderson
/// Student No. 170453905

import 'dart:typed_data';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

/// Provides methods for required database operations.
class DatabaseHelper {

  /// Loads in a database asset.
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

  /// Loads in a single database asset.
  static Future<bool> loadSingular(BuildContext context, String dbName) async {
    String dbsPath = await getDatabasesPath();
    return await _load(context, dbsPath, dbName);
  }

  /// Loads in multiple database assets.
  static Future<bool> loadAll(BuildContext context, List<String> dbNames) async {
    // Path on device where databases are stored.
    String dbsPath = await getDatabasesPath();
    // Execute the method for loading a single DB for all to be loaded.
    for(String dbName in dbNames) {
      await _load(context, dbsPath, dbName);
    }
    return true;
  }

  /// Returns the results of a database query.
  static Future<List<Map<String, dynamic>>> query(String query) async {
    // Path on device where databases are stored.
    String dbsPath = await getDatabasesPath();
    // Required name of a database in the app.
    String dbPath = join(dbsPath, "data.db");

    //Connect to database and return query results.
    Database database = await openDatabase(dbPath);
    List<Map<String, dynamic>> queryResults;
    await database.transaction((txn) async {
      queryResults = await txn.rawQuery(query);
    });

    return queryResults;
  }
}