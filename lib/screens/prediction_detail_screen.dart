import 'package:flutter/material.dart';
import 'log_symptoms_screen.dart';

class PredictionDetailScreen extends StatelessWidget {
  final String condition;
  final String severity;
  final Map<String, dynamic>? selectedDay;

  const PredictionDetailScreen({
    super.key,
    required this.condition,
    required this.severity,
    this.selectedDay,
  });

  Map<String, Map<String, dynamic>> get _conditionData => {
    'migraine': {
      'activity': 'Running',
      'warning': 'Which may increase your pain',
      'factors': [
        {'name': 'Weather Changes', 'percentage': 0.30},
        {'name': 'Menstrual Cycle', 'percentage': 0.60},
        {'name': 'Allergies', 'percentage': 0.10},
      ],
      'triggers': [
        {'name': 'High Impact Exercise', 'icon': Icons.fitness_center},
        {'name': 'Sitting', 'icon': Icons.event_seat},
        {'name': 'Standing', 'icon': Icons.accessibility_new},
      ],
    },
    'back': {
      'activity': 'Heavy Lifting',
      'warning': 'This activity may strain your back',
      'factors': [
        {'name': 'Physical Activity', 'percentage': 0.70},
        {'name': 'Posture', 'percentage': 0.20},
        {'name': 'Weather Changes', 'percentage': 0.10},
      ],
      'triggers': [
        {'name': 'Lifting', 'icon': Icons.fitness_center},
        {'name': 'Poor Posture', 'icon': Icons.airline_seat_recline_normal},
        {'name': 'Long Sitting', 'icon': Icons.event_seat},
      ],
    },
    'knee': {
      'activity': 'Walking',
      'warning': 'Consider reducing high-impact activities',
      'factors': [
        {'name': 'Weather Changes', 'percentage': 0.60},
        {'name': 'Menstrual Cycle', 'percentage': 0.05},
        {'name': 'Allergies', 'percentage': 0.35},
      ],
      'triggers': [
        {'name': 'Stairs', 'icon': Icons.stairs},
        {'name': 'Standing', 'icon': Icons.accessibility_new},
        {'name': 'Weather Changes', 'icon': Icons.wb_sunny},
      ],
    },
    'neck': {
      'activity': 'Computer Work',
      'warning': 'Remember to take regular breaks',
      'factors': [
        {'name': 'Posture', 'percentage': 0.55},
        {'name': 'Screen Time', 'percentage': 0.35},
        {'name': 'Stress', 'percentage': 0.10},
      ],
      'triggers': [
        {'name': 'Poor Posture', 'icon': Icons.airline_seat_recline_normal},
        {'name': 'Screen Time', 'icon': Icons.computer},
        {'name': 'Stress', 'icon': Icons.psychology},
      ],
    },
    'hip': {
      'activity': 'Jogging',
      'warning': 'Consider low-impact alternatives',
      'factors': [
        {'name': 'Physical Activity', 'percentage': 0.45},
        {'name': 'Weather Changes', 'percentage': 0.30},
        {'name': 'Posture', 'percentage': 0.25},
      ],
      'triggers': [
        {'name': 'Running', 'icon': Icons.directions_run},
        {'name': 'Prolonged Standing', 'icon': Icons.accessibility_new},
        {'name': 'Weather Changes', 'icon': Icons.wb_sunny},
      ],
    },
  };

  String _getActivityDate() {
    if (selectedDay == null) return 'Yesterday';
    final bool isToday = selectedDay!['date'] == '28'; // Wednesday is today
    if (isToday) return 'Yesterday';
    return selectedDay!['day'] ?? 'Yesterday';
  }

  Widget _buildProgressBar(String factor, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              factor,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC857),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTriggerChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'severe':
        return const Color(0xFFFFE5E5);
      case 'moderate':
        return const Color(0xFFFFF3D6);
      case 'mild':
        return const Color(0xFFE5FFE9);
      default:
        return const Color(0xFFFFF3D6);
    }
  }

  Color _getSeverityTextColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'severe':
        return Colors.red[700]!;
      case 'moderate':
        return Colors.orange[700]!;
      case 'mild':
        return Colors.green[700]!;
      default:
        return Colors.orange[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final conditionKey = condition.toLowerCase();
    final data = _conditionData[conditionKey]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back to predictions',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                condition,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getSeverityColor(severity),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    fontSize: 14,
                    color: _getSeverityTextColor(severity),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '${_getActivityDate()} you logged:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3D6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              data['activity'],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data['warning'],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Contributing Factors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...data['factors'].map<Widget>((factor) => 
            _buildProgressBar(factor['name'], factor['percentage']),
          ),
          const SizedBox(height: 8),
          const Text(
            'Common Triggers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final trigger in data['triggers'])
                _buildTriggerChip(trigger['name'], trigger['icon']),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogSymptomsScreen(
                    selectedDate: DateTime(2024, 4, 28), // Wednesday
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC857),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Log Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 