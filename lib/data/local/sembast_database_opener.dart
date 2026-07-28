// lib/data/local/sembast_database_opener.dart
import 'package:sembast/sembast.dart';

import 'sembast_database_opener_stub.dart'
    if (dart.library.io) 'sembast_database_opener_io.dart'
    if (dart.library.html) 'sembast_database_opener_web.dart';

Future<Database> openSembastDatabase(String dbName) =>
    openSembastDatabaseImpl(dbName);
