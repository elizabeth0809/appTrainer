import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainer_app/config/theme/app_theme.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
 
  final List<String> availableTimes;
  final Function(String)? onTimeSelected;

  const DateSelector({
    super.key,
    this.onDateSelected,
    
    required this.availableTimes,
    this.onTimeSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedMonth = DateTime.now();
  bool showCalendar = false;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    List<DateTime> dates = [
      selectedDate.subtract(const Duration(days: 1)),
      selectedDate,
      selectedDate.add(const Duration(days: 1)),
    ];

    return Column(
      children: [

        /// ================= TOP DATE BAR =================
        Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: dates.map((date) {
                    final isSelected =
                        DateUtils.isSameDay(date, selectedDate);

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                            focusedMonth = date;
                          });

                          widget.onDateSelected?.call(date);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorSeed
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd/MM').format(date),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getLabel(date),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Colors.white70
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// VER CALENDARIO BUTTON
            GestureDetector(
              onTap: () {
                setState(() {
                  showCalendar = !showCalendar;
                });
              },
              child: Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                    color: 
                      colorSeed,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month,
                        color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      "ver calendário",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        /// ================= CALENDAR =================
        if (showCalendar) _buildCalendar(),
        /// ================= HORARIOS =================
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Escolha um horário"),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.availableTimes.map((time) {
                    final isSelected = selectedTime == time;

                    return ChoiceChip(
                      label: Text(time),
                      selected: isSelected,
                      selectedColor: colorSeed,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.black,
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedTime = time;
                        });
                        widget.onTimeSelected?.call(time);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ================= CALENDAR WIDGET =================
  Widget _buildCalendar() {
    final days = _buildCalendarDays(focusedMonth);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      focusedMonth = DateTime(
                          focusedMonth.year,
                          focusedMonth.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy', 'pt_BR')
                      .format(focusedMonth),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      focusedMonth = DateTime(
                          focusedMonth.year,
                          focusedMonth.month + 1);
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// WEEK DAYS
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: const [
                _WeekDay("Dom"),
                _WeekDay("Seg"),
                _WeekDay("Ter"),
                _WeekDay("Qua"),
                _WeekDay("Qui"),
                _WeekDay("Sex"),
                _WeekDay("Sáb"),
              ],
            ),

            const SizedBox(height: 10),

            /// GRID
            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                final date = days[index];
                final isCurrentMonth =
                    date.month == focusedMonth.month;
                final isSelected = DateUtils.isSameDay(
                    date, selectedDate);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                      showCalendar = false;
                    });

                    widget.onDateSelected?.call(date);
                  },
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: isSelected
                          ? const BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorSeed,
                            )
                          : null,
                      alignment: Alignment.center,
                      child: Text(
                        "${date.day}",
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : isCurrentMonth
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _buildCalendarDays(DateTime month) {
    final firstDay =
        DateTime(month.year, month.month, 1);
    final firstWeekday =
        firstDay.weekday % 7; // Domingo=0
    final startDate =
        firstDay.subtract(Duration(days: firstWeekday));

    return List.generate(
      42,
      (index) => startDate.add(Duration(days: index)),
    );
  }

  String _getLabel(DateTime date) {
    final today = DateTime.now();

    if (DateUtils.isSameDay(date, today)) {
      return 'hoje';
    } else if (DateUtils.isSameDay(
        date, today.add(const Duration(days: 1)))) {
      return 'amanhã';
    } else {
      return DateFormat('EEEE', 'pt_BR').format(date);
    }
  }
}

class _WeekDay extends StatelessWidget {
  final String text;
  const _WeekDay(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}