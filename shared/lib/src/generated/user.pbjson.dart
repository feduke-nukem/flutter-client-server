//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use optionalUserDescriptor instead')
const OptionalUser$json = {
  '1': 'OptionalUser',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.User', '9': 0, '10': 'user'},
    {'1': 'null_user', '3': 2, '4': 1, '5': 14, '6': '.google.protobuf.NullValue', '9': 0, '10': 'nullUser'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `OptionalUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionalUserDescriptor = $convert.base64Decode(
    'CgxPcHRpb25hbFVzZXISGwoEdXNlchgBIAEoCzIFLlVzZXJIAFIEdXNlchI5CgludWxsX3VzZX'
    'IYAiABKA4yGi5nb29nbGUucHJvdG9idWYuTnVsbFZhbHVlSABSCG51bGxVc2VyQgYKBGtpbmQ=');

@$core.Deprecated('Use userUpdateRequestDescriptor instead')
const UserUpdateRequest$json = {
  '1': 'UserUpdateRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `UserUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdateRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyVXBkYXRlUmVxdWVzdBIOCgJpZBgBIAEoBVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ'
    '==');

@$core.Deprecated('Use usersDescriptor instead')
const Users$json = {
  '1': 'Users',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.User', '10': 'users'},
  ],
};

/// Descriptor for `Users`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersDescriptor = $convert.base64Decode(
    'CgVVc2VycxIbCgV1c2VycxgBIAMoCzIFLlVzZXJSBXVzZXJz');

