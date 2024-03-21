import 'dart:io';

import 'package:server/src/service/user_controller.dart';
import 'package:server/src/util/map_x.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as serve_io;
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:stormberry/stormberry.dart';

late final Database _db;

Future<void> main() async {
  _db = Database(
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'changeme',
    database: 'flutter-client-server',
    useSSL: false,
  );
  await _db.open();

  withHotreload(() => createServer(), logLevel: Level.WARNING);
}

Future<HttpServer> createServer() async {
  final userController = UserController();

  final router = Router()..mount('/user', userController.handler);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware((_dbProvider))
      .addHandler(router.call);

  final server = await serve_io.serve(
    handler,
    InternetAddress.anyIPv6,
    8080,
    poweredByHeader: 'feduke-nukem',
  );

  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');

  return server;
}

Handler _dbProvider(Handler innerHandler) {
  return (request) async => innerHandler(
        request.change(context: request.context.provide<Database>(() => _db)),
      );
}
