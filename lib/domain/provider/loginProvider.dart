import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/service/repositoryService.dart';
final loginProvider = StateNotifierProvider((ref){
  final repositoryService = ref.read(repositoryProvider);
  return LoginNotifier( LoginState(), repositoryService);
});
class LoginState {
  final User? user;

  LoginState({ this.user});
  LoginState copyWith({
    User? user
  }){
    return LoginState(user: user ?? this.user);
  }
}

class LoginNotifier extends StateNotifier<LoginState>{
  final RepositoryService repositoryService;
  LoginNotifier(super.state,  this.repositoryService);
  Future<void> login(String email, String password) async{
    try{
      final user = await repositoryService.authRepository.login(email, password);
    state = state.copyWith(user:user);
    } catch(err){
      debugPrint('$err');
      rethrow;
    }
  }
}