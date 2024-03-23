/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:user_app_client/src/protocol/user.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<List<_i3.User>> getAll() =>
      caller.callServerEndpoint<List<_i3.User>>(
        'user',
        'getAll',
        {},
      );

  _i2.Future<_i3.User> create(String name) =>
      caller.callServerEndpoint<_i3.User>(
        'user',
        'create',
        {'name': name},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'user',
        'delete',
        {'id': id},
      );

  _i2.Future<_i3.User?> get(int id) => caller.callServerEndpoint<_i3.User?>(
        'user',
        'get',
        {'id': id},
      );

  _i2.Future<_i3.User> patch(
    int id,
    String name,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'user',
        'patch',
        {
          'id': id,
          'name': name,
        },
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    user = EndpointUser(this);
  }

  late final EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'user': user};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
