import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';

final _db = MyDatabase.create();
final userDao = UserDao(_db);

Handler middleware(Handler handler) {
  return handler.use(provider<UserDao>((_) => userDao)).use(requestLogger());
}
