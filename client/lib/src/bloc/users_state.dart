part of 'users_bloc.dart';

@immutable
sealed class UsersState {
  const UsersState();

  Iterable<User> get users;

  Iterable<User> get processingUsers;

  UsersState copyWith({
    Iterable<User>? users,
    Iterable<User>? processingUsers,
  }) =>
      switch (this) {
        UsersInitial() => const UsersInitial(),
        UsersLoading() => UsersLoading(
            users: users ?? this.users,
            processingUsers: processingUsers ?? this.processingUsers,
          ),
        UsersIdle() => UsersIdle(
            users: users ?? this.users,
            processingUsers: processingUsers ?? this.users,
          ),
        UsersError(:final error) => UsersError(
            error: error,
            users: users ?? this.users,
            processingUsers: processingUsers ?? this.processingUsers,
          ),
      };
}

final class UsersInitial extends UsersState {
  @override
  Iterable<User> get users => const [];

  @override
  Iterable<User> get processingUsers => const [];

  const UsersInitial();
}

final class UsersLoading extends UsersState {
  @override
  final Iterable<User> users;

  @override
  final Iterable<User> processingUsers;

  const UsersLoading({
    required this.users,
    required this.processingUsers,
  });
}

final class UsersIdle extends UsersState {
  @override
  final Iterable<User> users;

  @override
  final Iterable<User> processingUsers;

  const UsersIdle({
    required this.users,
    required this.processingUsers,
  });
}

final class UsersError extends UsersState {
  final Object error;

  @override
  final Iterable<User> users;

  @override
  final Iterable<User> processingUsers;

  const UsersError({
    required this.error,
    required this.users,
    required this.processingUsers,
  });
}
