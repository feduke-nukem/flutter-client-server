import 'package:shared/shared.dart' as shared;

class User {
  final int id;
  final String name;

  const User({required this.id, required this.name});
}

class UserService {
  final shared.UserServiceClient _client;

  UserService(this._client);

  Future<User?> get(int id) async {
    final response = await _client.get(shared.Int32Value(value: id));

    if (!response.hasUser()) return null;

    return User(
      id: response.user.id,
      name: response.user.name,
    );
  }

  Future<List<User>> getAll() async {
    final response = await _client.getAll(shared.Empty());

    return (response.users).map((e) => User(id: e.id, name: e.name)).toList();
  }

  Future<User> create(String name) async {
    final response = await _client.create(shared.StringValue(value: name));

    return User(id: response.id, name: response.name);
  }

  Future<User> update(int id, String name) async {
    final response = await _client.update(
      shared.UserUpdateRequest(id: id, name: name),
    );

    return User(id: response.id, name: response.name);
  }

  Future<void> delete(int id) => _client.delete(shared.Int32Value(value: id));

  Stream<Iterable<User>> watch() => _client
      .watchUsers(shared.Empty())
      .map((event) => event.users.map((e) => User(id: e.id, name: e.name)));
}
