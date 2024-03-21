import 'package:database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';
part 'models.freezed.dart';

@freezed
class User with _$User {
  /// @nodoc
  const factory User({
    required int id,
    required String name,
  }) = _User;

  /// @nodoc
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromDb(UserView data) => User(
        id: data.id,
        name: data.name,
      );
}
