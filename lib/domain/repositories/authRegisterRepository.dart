import 'dart:convert';

import 'package:trainer_app/global/http.dart';

import '../models/model.dart';

class AuthRegisterRepository {
  const AuthRegisterRepository(this.apiRegister);
  final HttpService apiRegister;
   Future<UserRegister> register(String name,String email, String password, String password_confirmation) async {
    //connectivity check!
    final body = jsonEncode({'name': name,'email': email, 'password': password, 'password_confirmation':password_confirmation});
    final userRegister = await apiRegister.register(body);
    return UserRegister.fromJson(userRegister);
  }
}