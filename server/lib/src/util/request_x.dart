import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';

extension RequestX on Request {
  Future<Map<String, dynamic>> json() async {
    return jsonDecode(await readAsString()) as Map<String, dynamic>;
  }
}
