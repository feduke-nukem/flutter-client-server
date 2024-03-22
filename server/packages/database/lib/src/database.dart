import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DriftDatabase(tables: [Users])
class MyDatabase extends _$MyDatabase {
  MyDatabase(super.e);

  @override
  int get schemaVersion => 1;

  factory MyDatabase.create() => MyDatabase(
        PgDatabase(
          endpoint: Endpoint(
            host: 'localhost',
            database: 'flutter-client-server',
            username: 'postgres',
            password: 'changeme',
          ),
          settings: ConnectionSettings(sslMode: SslMode.disable),
        ),
      );
}
