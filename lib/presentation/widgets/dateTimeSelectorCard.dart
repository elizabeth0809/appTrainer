import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;

  const DateTimeSelector({
    super.key,
    required this.onChanged,
  });

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

        // ─────────────── DATE SELECTOR ───────────────
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: daysToShow,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _isSameDay(date, selectedDate);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                    _emitDateTime();
                  });
                },
                child: _dateItem(date, isSelected),
              );
            },
          ),
        ),
Row(
  children: [
    const Icon(Icons.calendar_month),
    const SizedBox(width: 12),
    Expanded(
      child: Text(
        'Día: ${selectedDate.day}/${selectedDate.month}',
      ),
    ),
    TextButton(
      onPressed: _pickDate,
      child: const Text('Cambiar'),
    ),
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
            TextButton(
              onPressed: _pickTime,
              child: const Text('Cambiar'),
            ),
          ],
        ),
      ],
    );
  }
Future<void> _pickDate() async {
  final date = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 30)),
    locale: const Locale('es', 'ES'),
  );

  if (date != null) {
    setState(() {
      selectedDate = date;
      _emitDateTime();
    });
  }
}

  // ─────────────── DATE ITEM ───────────────
  Widget _dateItem(DateTime date, bool isSelected) {
    final dayName = DateFormat.E('es').format(date);
    final dayNumber = date.day.toString();

    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _capitalize(dayName),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            dayNumber,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────── TIME PICKER ───────────────
  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

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

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1, 3);
  }
}
