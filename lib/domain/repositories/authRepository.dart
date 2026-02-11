import 'dart:convert';

import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/http.dart';


class AuthRepository {
  final HttpService api;
  const AuthRepository(this.api);
  Future<User> login(String email, String password) async {
    //connectivity check!
    final body = jsonEncode({'email': email, 'password': password});
    final user = await api.login(body);
    return User.fromJson(user);
  }
}