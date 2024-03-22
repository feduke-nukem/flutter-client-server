import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<UserDao>((_) => userDao)).use(requestLogger());
}
