import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalBookings = 120;
    final totalRevenue = 3500;
    final totalUsers = 45;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _ReportCard(
                    title: "Agendamientos",
                    value: totalBookings.toString(),
                    icon: Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ReportCard(
                    title: "Ingresos",
                    value: "\$$totalRevenue",
                    icon: Icons.attach_money,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _ReportCard(
                    title: "Usuarios",
                    value: totalUsers.toString(),
                    icon: Icons.people,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: const Center(
                child: Text('Aquí va un gráfico 📈'),
              ),
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top ejercicios',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 10),

            _TopItem(title: "Estiramiento", value: "45 usos"),
            _TopItem(title: "Crossfit", value: "30 usos"),
            _TopItem(title: "Yoga", value: "20 usos"),
          ],
        ),
      ),
    );
  }
}
class _ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ReportCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18)),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
class _TopItem extends StatelessWidget {
  final String title;
  final String value;

  const _TopItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(title),
      trailing: Text(value),
    );
  }
}