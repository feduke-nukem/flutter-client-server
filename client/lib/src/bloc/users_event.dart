part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {
  const UsersEvent();
}

class UsersStarted extends UsersEvent {
  const UsersStarted();
}

class UserAdded extends UsersEvent {
  final String name;

  const UserAdded({required this.name});
}

class UserUpdated extends UsersEvent {
  final int id;
  final String name;

  const UserUpdated({required this.id, required this.name});
}

class UserDeleted extends UsersEvent {
  final int id;

  const UserDeleted({required this.id});
}
