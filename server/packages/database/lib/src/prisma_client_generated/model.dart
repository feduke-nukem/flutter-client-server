library prisma.namespace.model;

class User {
  const User({
    this.id,
    this.name,
  });

  factory User.fromJson(Map json) => User(
        id: json['id'],
        name: json['name'],
      );

  final int? id;

  final String? name;
}
