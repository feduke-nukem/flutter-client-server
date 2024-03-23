import 'package:serverpod/serverpod.dart';
import 'package:user_app_server/src/generated/user.dart';

class UserEndpoint extends Endpoint {
  Future<List<User>> getAll(Session session) {
    return User.db.find(session);
  }

  Future<User> create(Session session, String name) {
    return User.db.insertRow(session, User(name: name));
  }

  Future<void> delete(Session session, int id) async {
    await User.db.deleteWhere(session, where: (tbl) => tbl.id.equals(id));
  }

  Future<User?> get(Session session, int id) async {
    return User.db.findById(session, id);
  }

  Future<User> patch(Session session, int id, String name) async {
    return User.db.updateRow(session, User(id: id, name: name));
  }
}
