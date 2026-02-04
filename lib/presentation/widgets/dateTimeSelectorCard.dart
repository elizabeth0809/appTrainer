import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;

  const DateTimeSelector({super.key, required this.onChanged});

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);

  final int daysToShow = 7;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dias disponibles',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        Row(
          children: [
            const Icon(Icons.calendar_month),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Día: ${selectedDate.day}/${selectedDate.month}'),
            ),
            TextButton(onPressed: _pickDate, child: const Text('Cambiar')),
          ],
        ),
        const SizedBox(height: 16),

        // ─────────────── TIME PICKER ───────────────
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Hora: ${selectedTime.format(context)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            TextButton(onPressed: _pickTime, child: const Text('Cambiar')),
          ],
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 30)),
    locale: const Locale('es', 'ES'),
  );

  if (!mounted) return;

  if (date != null) {
    setState(() {
      selectedDate = date;
      _emitDateTime();
    });
  }
}
  // ─────────────── TIME PICKER ───────────────
 Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      // No fuerces el locale aquí si ya lo configuraste en el main.dart
    );

    if (!mounted) return; // <--- AGREGAR ESTO

    if (time != null) {
      setState(() {
        selectedTime = time;
        _emitDateTime();
      });
    }
  }

  // ─────────────── EMIT DATETIME ───────────────
  void _emitDateTime() {
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    widget.onChanged(dateTime);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
