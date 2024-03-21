import 'dart:convert';
import 'dart:io';

import 'package:database/database.dart';
import 'package:server/src/util/map_x.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:stormberry/stormberry.dart';
import 'package:shared/shared.dart' as shared;

part 'user_controller.g.dart';

class UserController {
  @Route.post('/')
  Future<Response> post(Request request) async {
    final db = request.context.read<Database>();

    final body = await request.readAsString();

    final id = await db.users.insertOne(UserInsertRequest(name: body));

    final user = await db.users.queryUser(id);

    if (user == null) {
      return Response.badRequest();
    }

    return Response(
      HttpStatus.created,
      body: jsonEncode(shared.User.fromDb(user)),
    );
  }

  @Route.get('/')
  Future<Response> getAll(Request request) async {
    final db = request.context.read<Database>();

    final result = await db.users.queryUsers();

    final users = result.map((e) => shared.User.fromDb(e)).toList();

    return Response(
      users.isEmpty ? HttpStatus.noContent : HttpStatus.ok,
      body: jsonEncode(users),
    );
  }

  @Route.delete('/<id>')
  Future<Response> delete(Request request, String id) async {
    final db = request.context.read<Database>();

    final userId = int.parse(id);

    final result = await db.users.queryUser(userId);

    if (result == null) {
      return Response.notFound(id);
    }

    try {
      await db.users.deleteOne(userId);
    } catch (e) {
      return Response.badRequest();
    }

    return Response.ok(null);
  }

  @Route.get('/<id>')
  Future<Response> get(Request request, String id) async {
    final db = request.context.read<Database>();

    final userId = int.parse(id);

    final user = await db.users.queryUser(userId);

    if (user == null) {
      return Response.notFound(id);
    }

    return Response.ok(
      jsonEncode(shared.User.fromDb(user)),
    );
  }

  @Route('PATCH', '/<id>')
  Future<Response> patch(Request request, String id) async {
    final db = request.context.read<Database>();

    final userId = int.parse(id);

    final user = await db.users.queryUser(userId);

    if (user == null) {
      return Response.notFound(id);
    }

    final name = request.url.queryParameters['name'];

    if (name == null) {
      return Response.badRequest();
    }

    await db.users.updateOne(UserUpdateRequest(id: userId, name: name));

    return Response.ok(
      jsonEncode(shared.User.fromDb(user).copyWith(name: name)),
    );
  }

  Handler get handler => _$UserControllerRouter(this).call;
}
