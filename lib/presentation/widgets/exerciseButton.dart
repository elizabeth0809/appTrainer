import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainer_app/domain/enum/ui_state.dart';
import 'package:trainer_app/domain/provider/exerciseProvider.dart';
import 'package:trainer_app/presentation/screens/screen.dart';
/*
class ExerciseButton extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController modalitiesController;
  final TextEditingController priceController;
  final TextEditingController imgController;
  const ExerciseButton({
    super.key, required this.nameController, required this.modalitiesController, required this.priceController, required this.imgController,
  
  });
  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(ExerciseProvider.select((value)=> value.uiState == UiState.loading));
    return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            key: key,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Fondo azul
              foregroundColor: Colors.white, // Texto e íconos blancos
            ),
            onPressed: isLoading ? null:() async {
              final price = int.tryParse(priceController.text);
              ref
                  .read(ExerciseProvider.notifier)
                  .exercise(nameController.text,price!,modalitiesController.text,  imgController.text)
                  .then((value){
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) =>HomeScreen() ));
                  })
                  .catchError((err, stackTrace){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$err')));
                  });
         
            },

            child:isLoading? CircularProgressIndicator(color: Colors.white): Text('Entrar'),
          ),
        );
  }
}*/