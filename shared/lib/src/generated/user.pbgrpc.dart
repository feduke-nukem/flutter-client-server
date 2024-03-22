//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $2;
import 'google/protobuf/wrappers.pb.dart' as $0;
import 'user.pb.dart' as $1;

export 'user.pb.dart';

@$pb.GrpcServiceName('UserService')
class UserServiceClient extends $grpc.Client {
  static final _$get = $grpc.ClientMethod<$0.Int32Value, $1.OptionalUser>(
      '/UserService/Get',
      ($0.Int32Value value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.OptionalUser.fromBuffer(value));
  static final _$create = $grpc.ClientMethod<$0.StringValue, $1.User>(
      '/UserService/Create',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$0.Int32Value, $2.Empty>(
      '/UserService/Delete',
      ($0.Int32Value value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$1.UserUpdateRequest, $1.User>(
      '/UserService/Update',
      ($1.UserUpdateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$getAll = $grpc.ClientMethod<$2.Empty, $1.Users>(
      '/UserService/GetAll',
      ($2.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Users.fromBuffer(value));
  static final _$watchUsers = $grpc.ClientMethod<$2.Empty, $1.Users>(
      '/UserService/WatchUsers',
      ($2.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Users.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.OptionalUser> get($0.Int32Value request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$1.User> create($0.StringValue request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> delete($0.Int32Value request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$1.User> update($1.UserUpdateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$1.Users> getAll($2.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseStream<$1.Users> watchUsers($2.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$watchUsers, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Int32Value, $1.OptionalUser>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Int32Value.fromBuffer(value),
        ($1.OptionalUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.User>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Int32Value, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Int32Value.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserUpdateRequest, $1.User>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserUpdateRequest.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $1.Users>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($1.Users value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $1.Users>(
        'WatchUsers',
        watchUsers_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($1.Users value) => value.writeToBuffer()));
  }

  $async.Future<$1.OptionalUser> get_Pre($grpc.ServiceCall call, $async.Future<$0.Int32Value> request) async {
    return get(call, await request);
  }

  $async.Future<$1.User> create_Pre($grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return create(call, await request);
  }

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall call, $async.Future<$0.Int32Value> request) async {
    return delete(call, await request);
  }

  $async.Future<$1.User> update_Pre($grpc.ServiceCall call, $async.Future<$1.UserUpdateRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$1.Users> getAll_Pre($grpc.ServiceCall call, $async.Future<$2.Empty> request) async {
    return getAll(call, await request);
  }

  $async.Stream<$1.Users> watchUsers_Pre($grpc.ServiceCall call, $async.Future<$2.Empty> request) async* {
    yield* watchUsers(call, await request);
  }

  $async.Future<$1.OptionalUser> get($grpc.ServiceCall call, $0.Int32Value request);
  $async.Future<$1.User> create($grpc.ServiceCall call, $0.StringValue request);
  $async.Future<$2.Empty> delete($grpc.ServiceCall call, $0.Int32Value request);
  $async.Future<$1.User> update($grpc.ServiceCall call, $1.UserUpdateRequest request);
  $async.Future<$1.Users> getAll($grpc.ServiceCall call, $2.Empty request);
  $async.Stream<$1.Users> watchUsers($grpc.ServiceCall call, $2.Empty request);
}
