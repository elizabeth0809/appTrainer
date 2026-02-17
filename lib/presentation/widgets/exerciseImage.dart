import 'dart:io';

import 'package:flutter/material.dart';

class ExerciseImage extends StatelessWidget {
  final String? url;

  const ExerciseImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      );

  // Widget para mostrar la imagen
  Widget getImage(String? picture) {
    // Si no hay imagen, mostrar placeholder
    if (picture == null || picture.isEmpty) {
      return Image.asset(
        'assets/no-image.png',
        fit: BoxFit.cover,
      );
    }

    // Si es una URL (http o https)
    if (picture.startsWith('http://') || picture.startsWith('https://')) {
      return FadeInImage(
        image: NetworkImage(picture),
        placeholder: const AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          print('Error cargando imagen de red: $error');
          return Image.asset(
            'assets/no-image.png',
            fit: BoxFit.cover,
          );
        },
      );
    }

    // Si es una ruta local, verificar que el archivo existe
    try {
      final file = File(picture);
      // Verificar si el archivo existe de manera asíncrona
      return FutureBuilder<bool>(
        future: file.exists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.data == true) {
            // El archivo existe, mostrarlo
            return Image.file(
              file,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error cargando archivo local: $error');
                return Image.asset(
                  'assets/no-image.png',
                  fit: BoxFit.cover,
                );
              },
            );
          } else {
            // El archivo no existe
            print('Archivo no encontrado: $picture');
            return Image.asset(
              'assets/no-image.png',
              fit: BoxFit.cover,
            );
          }
        },
      );
    } catch (e) {
      print('Error al acceder al archivo: $e');
      return Image.asset(
        'assets/no-image.png',
        fit: BoxFit.cover,
      );
    }
  }
}