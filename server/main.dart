import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

final db = Database(
  host: 'localhost',
  port: 5432,
  username: 'postgres',
  password: 'changeme',
  database: 'flutter-client-server',
  useSSL: false,
);

Future<void> init(InternetAddress ip, int port) async => db.open();

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
