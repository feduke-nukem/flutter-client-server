import 'package:database/database.dart';
import 'package:drift/drift.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  UserDao(super.attachedDatabase);

  Future<User> create(String name) async {
    return attachedDatabase.users.insertReturning(
      UsersCompanion.insert(name: name),
    );
  }

  Future<User?> getById(int id) {
    return (attachedDatabase.users.select()..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<Iterable<User>> getAll() => attachedDatabase.users.select().get();

  Future<void> deleteById(int id) =>
      attachedDatabase.users.deleteWhere((tbl) => tbl.id.equals(id));

  Future<User> updateName(int id, String name) {
    return (update(attachedDatabase.users)..where((tbl) => tbl.id.equals(id)))
        .writeReturning(UsersCompanion.insert(name: name))
        .then((value) => value.first);
  }
}
