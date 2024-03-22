import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
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
  final dao = context.read<UserDao>();

  final name = await context.request.body();

  final user = await dao.create(name);

  return Response.json(
    statusCode: HttpStatus.created,
    body: shared.User.fromDb(user),
  );
}

Future<Response> _onGet(RequestContext context) async {
  final dao = context.read<UserDao>();

  final result = await dao.getAll();

  final users = result.map((e) => shared.User.fromDb(e)).toList();

  return Response.json(
    statusCode: users.isEmpty ? HttpStatus.noContent : HttpStatus.ok,
    body: users,
  );
}
