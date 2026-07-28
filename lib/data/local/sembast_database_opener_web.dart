// lib/data/local/sembast_database_opener_web.dart
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

Future<Database> openSembastDatabaseImpl(String dbName) {
  return databaseFactoryWeb.openDatabase(dbName);
}
