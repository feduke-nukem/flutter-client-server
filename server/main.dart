import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';

final db = PrismaClient();
final userDao = UserDao(db);

Future<void> init(InternetAddress ip, int port) async => db.$connect();

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
