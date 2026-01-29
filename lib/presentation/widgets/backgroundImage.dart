import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  //final String? url;

  //const _BackgroundImage(this.url);
  const BackgroundImage();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 250,
        height: 250,
        //si no hay imagen
        //child: url == null ?
        child: Image(
                image: AssetImage('assets/contrasena.png'),
                fit: BoxFit.cover,
              )
           /* : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),*/
      ),
    );
  }
}