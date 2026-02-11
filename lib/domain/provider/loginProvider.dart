import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trainer_app/domain/enum/ui_state.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/service/repositoryService.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref){
  final repositoryService = ref.read(repositoryProvider);
  return LoginNotifier( LoginState(), repositoryService);
});
class LoginState {
  final User? user;
  final UiState uiState;
  LoginState({ this.user, this.uiState = UiState.data});
  LoginState copyWith({
    User? user,
    UiState? uiState
  }){
    return LoginState(
      user: user ?? this.user, 
      uiState: uiState ?? this.uiState);
  }
}

class LoginNotifier extends StateNotifier<LoginState>{
  final RepositoryService repositoryService;
  LoginNotifier(super.state,  this.repositoryService);
  Future<void> login(String email, String password) async{
    state = state.copyWith(uiState: UiState.loading);
    try{
      final user = await repositoryService.authRepository.login(email, password);
    state = state.copyWith(user:user);
    } catch(err){
      debugPrint('$err');
      rethrow;
    } finally {state = state.copyWith(uiState: UiState.data);};
  }
}