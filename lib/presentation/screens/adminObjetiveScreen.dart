import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/controller/controller.dart';
import 'package:trainer_app/domain/provider/provider.dart';


class AdminObjetiveScreen extends ConsumerWidget {
  const AdminObjetiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final objetivosAsync = ref.watch(objetivosFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetivos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(objetivosFutureProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateObjetiveForm(context, ref);
        },
        child: const Icon(Icons.add),
      ),

      body: objetivosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, _) => Center(child: Text('Error: $err')),

        data: (objetives) {
          if (objetives.isEmpty) {
            return const Center(child: Text('No hay objetivos'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: objetives.length,
            itemBuilder: (context, index) {
              final obj = objetives[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(obj.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          showEditObjetiveForm(context, ref, obj);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref
                              .read(objetiveControllerProvider.notifier)
                              .delete(obj.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void showEditObjetiveForm(BuildContext context, WidgetRef ref, dynamic obj) {
  final updatecontroller = TextEditingController(text: obj.name);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Editar Objetivo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: updatecontroller,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (updatecontroller.text.isEmpty) return;

                  ref.read(objetiveControllerProvider.notifier).update(obj.id, {
                    "name": updatecontroller.text,
                  });

                  Navigator.pop(context);
                },
                child: const Text('Actualizar'),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showCreateObjetiveForm(BuildContext context, WidgetRef ref) {
  final createcontroller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Crear Objetivo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: createcontroller,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (createcontroller.text.isEmpty) return;

                  ref.read(objetiveControllerProvider.notifier).create({
                    "name": createcontroller.text,
                  });

                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
