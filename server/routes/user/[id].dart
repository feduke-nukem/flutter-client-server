import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';
import 'package:stormberry/stormberry.dart';
import 'package:shared/shared.dart' as shared;

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  switch (context.request.method) {
    case HttpMethod.delete:
      return _onDelete(context, id);
    case HttpMethod.get:
      return _onGet(context, id);
    case HttpMethod.patch:
      return _onPatch(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.post:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _onGet(
  RequestContext context,
  String id,
) async {
  final db = context.read<Database>();

  final userId = int.parse(id);

  final user = await db.users.queryUser(userId);

  if (user == null) {
    return Response(
      statusCode: HttpStatus.notFound,
      body: id,
    );
  }

  return Response.json(body: shared.User.fromDb(user));
}

Future<Response> _onPatch(RequestContext context, String id) async {
  final db = context.read<Database>();

  final userId = int.parse(id);

  final user = await db.users.queryUser(userId);

  if (user == null) {
    return Response(
      statusCode: HttpStatus.notFound,
      body: id,
    );
  }

  final name = context.request.url.queryParameters['name'];

  if (name == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  await db.users.updateOne(UserUpdateRequest(id: userId, name: name));

  return Response.json(
    body: shared.User.fromDb(user).copyWith(name: name),
  );
}

Future<Response> _onDelete(
  RequestContext context,
  String id,
) async {
  final db = context.read<Database>();

  final userId = int.parse(id);

  final result = await db.users.queryUser(userId);

  if (result == null) {
    return Response(
      statusCode: HttpStatus.notFound,
      body: id,
    );
  }

  try {
    await db.users.deleteOne(userId);
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  return Response(statusCode: HttpStatus.noContent);
}
