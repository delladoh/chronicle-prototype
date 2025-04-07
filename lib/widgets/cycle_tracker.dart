import 'package:flutter/material.dart';

class CycleTracker extends StatelessWidget {
  const CycleTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cycle Tracker',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'April 2025',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Day 14',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFB74D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Table(
            children: [
              TableRow(
                children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                    .map((day) => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _buildCalendarGrid(),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCycleInfo('Cycle Length', '28 days'),
              _buildCycleInfo('Period Length', '5 days'),
              _buildCycleInfo('Next Period', 'in 14 days'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'Pain Impact',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A73C7)),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Medium',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFFFB74D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final List<Widget> calendarDays = [];
    final daysInMonth = 30;
    final firstDayOffset = 6; // Starting from Sunday

    // Add empty spaces for days before the 1st
    for (var i = 0; i < firstDayOffset; i++) {
      calendarDays.add(const SizedBox());
    }

    // Add the days of the month
    for (var i = 1; i <= daysInMonth; i++) {
      final isToday = i == 26;
      final isPeriodDay = i >= 27 && i <= 30;

      calendarDays.add(
        Center(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isToday
                  ? const Color(0xFF4A73C7)
                  : isPeriodDay
                      ? const Color(0xFFFFEBEE)
                      : null,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(
                  fontSize: 11,
                  color: isToday
                      ? Colors.white
                      : isPeriodDay
                          ? const Color(0xFFE57373)
                          : Colors.black87,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: calendarDays,
    );
  }

  Widget _buildCycleInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
} 