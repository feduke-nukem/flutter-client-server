import 'dart:async';

import 'package:database/database.dart' as db;
import 'package:grpc/service_api.dart';
import 'package:shared/shared.dart';

class UserService extends UserServiceBase {
  final db.UserDao _dao;

  UserService({required db.UserDao dao}) : _dao = dao;

  @override
  Future<User> create(ServiceCall call, StringValue request) async {
    final result = await _dao.create(request.value);

    return User(id: result.id, name: result.name);
  }

  @override
  Future<User> update(ServiceCall call, UserUpdateRequest request) async {
    final user = await _dao.updateName(request.id, request.name);

    return User(id: user.id, name: user.name);
  }

  @override
  Future<OptionalUser> get(ServiceCall call, Int32Value request) async {
    final user = await _dao.getById(request.value);

    if (user == null) {
      return OptionalUser(nullUser: NullValue.NULL_VALUE);
    }
    final s = User(id: user.id, name: user.name);
    s.id;
    return OptionalUser(
      user: User(id: user.id, name: user.name),
    );
  }

  @override
  Future<Users> getAll(ServiceCall call, Empty request) async {
    final users = await _dao.getAll();

    return Users(
      users: users.map((e) => User(id: e.id, name: e.name)).toList(),
    );
  }

  @override
  Stream<Users> watchUsers(ServiceCall call, Empty request) => _dao.stream.map(
        (event) => Users(
          users: event.map((e) => User(id: e.id, name: e.name)).toList(),
        ),
      );

  @override
  Future<Empty> delete(ServiceCall call, Int32Value request) async {
    await _dao.deleteById(request.value);

    return Empty();
  }
}
