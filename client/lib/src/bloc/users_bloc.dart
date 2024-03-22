import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/src/service/user_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserService _userService;
  late final StreamSubscription<Iterable<User>> _subscription;

  UsersBloc(this._userService) : super(const UsersInitial()) {
    on<UsersEvent>(
      (event, emit) {
        return switch (event) {
          UsersStarted() => _onStarted(emit),
          UserAdded() => _onAdded(event, emit),
          UserUpdated() => _onUpdated(event, emit),
          UserDeleted() => _onDeleted(event, emit),
          UsersRefreshed() => _onRefreshed(emit),
          _UsersChanged() => emit(state.copyWith(users: event.users)),
        };
      },
      transformer: (events, mapper) => events.asyncExpand(mapper),
    );

    _subscription = _userService.watch().listen(
          (users) => add(_UsersChanged(users: users)),
        );
  }

  Future<void> _onStarted(Emitter<UsersState> emit) async {
    if (state is! UsersInitial) return;

    try {
      final users = await _userService.getAll();

      emit(
        UsersIdle(
          users: users,
          processingUsers: state.processingUsers,
        ),
      );
    } catch (e) {
      emit(
        UsersError(
          error: e,
          users: state.users,
          processingUsers: state.processingUsers,
        ),
      );
    }
  }

  Future<void> _onRefreshed(Emitter<UsersState> emit) async {
    if (state is UsersLoading) return;

    try {
      final users = await _userService.getAll();

      emit(
        UsersIdle(
          users: users,
          processingUsers: state.processingUsers,
        ),
      );
    } catch (e) {
      emit(
        UsersError(
          error: e,
          users: state.users,
          processingUsers: state.processingUsers,
        ),
      );
    }
  }

  Future<void> _onAdded(UserAdded event, Emitter<UsersState> emit) async {
    if (state is UsersInitial || state is UsersLoading) return;

    if (event.name.isEmpty) return;

    emit(
      UsersLoading(
        users: state.users,
        processingUsers: state.processingUsers,
      ),
    );

    try {
      await _userService.create(event.name);

      emit(
        UsersIdle(
          users: state.users,
          processingUsers: state.processingUsers,
        ),
      );
    } catch (e) {
      emit(
        UsersError(
          error: e,
          users: state.users,
          processingUsers: state.processingUsers,
        ),
      );
    }
  }

  Future<void> _onDeleted(UserDeleted event, Emitter<UsersState> emit) async {
    if (state is UsersInitial || state is UsersLoading) return;

    final user = state.users.firstWhereOrNull((u) => u.id == event.id);

    if (user == null || state.processingUsers.contains(user)) return;

    emit(
      UsersIdle(
        users: state.users,
        processingUsers: [...state.processingUsers, user],
      ),
    );

    try {
      await _userService.delete(event.id);
      emit(
        UsersIdle(
          users: state.users,
          processingUsers:
              state.processingUsers.where((u) => u.id != event.id).toList(),
        ),
      );
    } catch (e) {
      emit(
        UsersError(
          error: e,
          users: state.users,
          processingUsers:
              state.processingUsers.where((u) => u.id != event.id).toList(),
        ),
      );
    }
  }

  Future<void> _onUpdated(UserUpdated event, Emitter<UsersState> emit) async {
    if (state is UsersInitial || state is UsersLoading) return;

    if (event.name.isEmpty) return;

    final user = state.users.firstWhereOrNull((u) => u.id == event.id);

    if (user == null || state.processingUsers.contains(user)) return;

    if (user.name == event.name) return;

    emit(
      UsersIdle(
        users: state.users,
        processingUsers: [...state.processingUsers, user],
      ),
    );

    try {
      await _userService.update(event.id, event.name);

      emit(
        UsersIdle(
          users: state.users,
          processingUsers:
              state.processingUsers.where((u) => u.id != event.id).toList(),
        ),
      );
    } catch (e) {
      emit(
        UsersError(
          error: e,
          users: state.users,
          processingUsers:
              state.processingUsers.where((u) => u.id != event.id).toList(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
