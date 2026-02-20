import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/widgets/widget.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Oi, Usuario',    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
        ],
        iconTheme: IconThemeData( color: Theme.of(context).colorScheme.onSurface,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
              'Informacion personal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              selectionColor:  Theme.of(context).colorScheme.surface,
            ),
            const Divider(height: 24),

            Infocard(),
            const SizedBox(height: 20),
            permissionsCard(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.push('/');
                    // Navigator.pushNamed(context, '/forget');
                  },
                  child: const Text(
                    'Cerrar sesion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                Image.asset('assets/off.png', width: 20)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
