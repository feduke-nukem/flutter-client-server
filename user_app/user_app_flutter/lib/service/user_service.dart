import 'package:user_app_client/user_app_client.dart';

class UserService {
  final Client _client;

  UserService(this._client);

  Future<User?> get(int id) => _client.user.get(id);

  Future<List<User>> getAll() => _client.user.getAll().then((u) => u.toList());

  Future<User> create(String name) => _client.user.create(name);

  Future<User> update(int id, String name) {
    return _client.user.patch(id, name);
  }

  Future<void> delete(int id) => _client.user.delete(id);
}
