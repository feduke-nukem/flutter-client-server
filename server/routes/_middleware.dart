import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<Database>((_) => db)).use(requestLogger());
}
