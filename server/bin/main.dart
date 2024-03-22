import 'dart:async';
import 'dart:io';

import 'package:database/database.dart';
import 'package:grpc/grpc.dart';
import 'package:server/src/user_service.dart';
import 'package:hotreloader/hotreloader.dart';

Server? _runningServer;
final db = MyDatabase.create();
final dao = UserDao(db);

Future<void> main(List<String> args) async {
  withHotReload(createServer: _createServer);
}

Future<Server> _createServer() async {
  final server = Server.create(
    services: [UserService(dao: dao)],
  );

  await server.serve(port: 8080);

  return server;
}

Future<void> withHotReload({
  required FutureOr<Server> Function() createServer,
  FutureOr<void> Function()? onReloaded,
}) async {
  onReloaded ??= () {
    final time = _formatTime(DateTime.now());
    stdout.writeln('[hotreload] $time - Application reloaded.');
  };
  obtainNewServer(FutureOr<Server> Function() create) async {
    var willReplaceServer = _runningServer != null;

    await _runningServer?.shutdown();

    if (willReplaceServer) {
      await onReloaded!.call();
    }

    final server = _runningServer = await create();
    stdout.writeln('Server listening on port ${server.port}...');
  }

  try {
    await HotReloader.create(onAfterReload: (ctx) {
      obtainNewServer(createServer);
    });
  } on StateError catch (e) {
    stderr.writeln(e);

    rethrow;
  }

  await obtainNewServer(createServer);
}

String _formatTime(DateTime time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  final second = time.second.toString().padLeft(2, '0');
  return '$hour:$minute:$second';
}
