import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:stormberry/stormberry.dart';
import 'package:shared/shared.dart' as shared;

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _onPost(context);
    case HttpMethod.get:
      return _onGet(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _onPost(RequestContext context) async {
  final db = context.read<Database>();

  final name = await context.request.body();

  final id = await db.users.insertOne(UserInsertRequest(name: name));

  final user = await db.users.queryUser(id);

  if (user == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  return Response.json(
    statusCode: HttpStatus.created,
    body: shared.User.fromDb(user),
  );
}

Future<Response> _onGet(RequestContext context) async {
  final db = context.read<Database>();

  final result = await db.users.queryUsers();

  final users = result.map((e) => shared.User.fromDb(e)).toList();

  return Response.json(
    statusCode: users.isEmpty ? HttpStatus.noContent : HttpStatus.ok,
    body: users,
  );
}
