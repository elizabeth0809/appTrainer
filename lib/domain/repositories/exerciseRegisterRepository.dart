import 'dart:convert';

import 'package:trainer_app/global/exerciseApi.dart';

import '../models/model.dart';
/*
class ExerciseRegisterRepository {
  const ExerciseRegisterRepository(this.apiExercise);
  final ExerciseApi apiExercise;
   Future<Exercise> createExercise(String name,int price, String modalities, String img) async {
    //connectivity check!
    final body = jsonEncode({'name': name,'price': price, 'modalities': modalities, 'img':img});
    final exerciseRegister = await apiExercise.createExercise(body);
    return Exercise.fromJson(exerciseRegister);
  }
}*/