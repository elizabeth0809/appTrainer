import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trainer_app/domain/enum/ui_state.dart';
import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/domain/service/repositoryRegisterService.dart';
final RegisterProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref){
  final repositoryRegisterService = ref.read(repositoryRegisterProvider);
  return RegisterNotifier( RegisterState(), repositoryRegisterService);
});
class RegisterState {
  final UserRegister? userRegister;
  final UiState uiState;
  RegisterState({ this.userRegister, this.uiState = UiState.data});
  RegisterState copyWith({
    UiState? uiState,
    UserRegister? userRegister
  }){
    return RegisterState(
      userRegister: userRegister ?? this.userRegister, 
      uiState: uiState ?? this.uiState);
  }
}

class RegisterNotifier extends StateNotifier<RegisterState>{
  final RepositoryRegisterService repositoryRegisterService;
  RegisterNotifier(super.state,  this.repositoryRegisterService);
  Future<void> register(String name, String email, String password, String password_confirmation) async{
    state = state.copyWith(uiState: UiState.loading);
    try{
      final userRegister = await repositoryRegisterService.authRegisterRepository.register(name,email, password, password_confirmation);
    state = state.copyWith(userRegister:userRegister);
    } catch(err){
      debugPrint('$err');
      rethrow;
    } finally {state = state.copyWith(uiState: UiState.data);};
  }
}