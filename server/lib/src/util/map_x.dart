extension MapX on Map<String, Object> {
  T read<T>() {
    final value = this['$T'];

    if (value is! T Function()) {
      throw StateError('value of $T type is not found');
    }

    return value();
  }

  Map<String, dynamic> provide<T>(T Function() create) {
    return {...this, '$T': create};
  }
}
