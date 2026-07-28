// lib/data/local/sembast_database_opener_io.dart
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> openSembastDatabaseImpl(String dbName) async {
  final appDir = await getApplicationDocumentsDirectory();
  return databaseFactoryIo.openDatabase('${appDir.path}/$dbName');
}
