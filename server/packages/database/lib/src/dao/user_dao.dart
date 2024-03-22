import 'package:database/database.dart';
import 'package:orm/orm.dart';

class UserDao {
  final PrismaClient _db;

  UserDao(this._db);

  Future<User> create(String name) {
    return _db.user.create(data: PrismaUnion.$1(UserCreateInput(name: name)));
  }

  Future<User?> getById(int id) {
    return _db.user.findFirst(where: UserWhereInput(id: PrismaUnion.$2(id)));
  }

  Future<Iterable<User>> getAll() => _db.user.findMany();

  Future<void> deleteById(int id) =>
      _db.user.delete(where: UserWhereUniqueInput(id: id));

  Future<void> updateName(int id, String name) => _db.user.update(
        where: UserWhereUniqueInput(id: id),
        data: PrismaUnion.$1(
          UserUpdateInput(
            name: PrismaUnion.$1(name),
          ),
        ),
      );
}
