import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'home_screen.dart';
import 'prediction_detail_screen.dart';
import 'log_symptoms_screen.dart';
import '../models/symptom_log.dart';
import '../models/app_state.dart';
import '../widgets/weekly_predictions.dart';

class DailyScreen extends StatefulWidget {
  final SymptomLog? initialLog;
  
  const DailyScreen({
    super.key,
    this.initialLog,
  });

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  int _selectedDayIndex = 2; // Default to Wednesday (index 2)
  late SymptomLog? _todaysLog;
  String? _selectedTime;
  bool _showForecastGraph = false;
  
  final List<Map<String, dynamic>> _days = [
    {
      'date': '24',
      'weekday': 'M',
      'day': 'Monday',
      'periodDay': 'No Period',
      'predictions': [
        {'condition': 'Migraine', 'severity': 'Mild'},
        {'condition': 'Back', 'severity': 'Moderate'},
      ],
      'slots': [
        {'time': '6AM', 'pain': 2},
        {'time': '9AM', 'pain': 4},
        {'time': '12PM', 'pain': 7},
        {'time': '3PM', 'pain': 8},
        {'time': '6PM', 'pain': 6},
        {'time': '9PM', 'pain': 5},
      ],
    },
    {
      'date': '25',
      'weekday': 'T',
      'day': 'Tuesday',
      'periodDay': 'No Period',
      'predictions': [
        {'condition': 'Neck', 'severity': 'Mild'},
        {'condition': 'Hip', 'severity': 'Severe'},
      ],
      'slots': [
        {'time': '6AM', 'pain': 3},
        {'time': '9AM', 'pain': 5},
        {'time': '12PM', 'pain': 6},
        {'time': '3PM', 'pain': 7},
        {'time': '6PM', 'pain': 5},
        {'time': '9PM', 'pain': 4},
      ],
    },
    {
      'date': '26',
      'weekday': 'W',
      'day': 'Wednesday',
      'periodDay': 1,
      'predictions': [
        {'condition': 'Migraine', 'severity': 'Moderate'},
      ],
      'slots': [
        {'time': '6AM', 'pain': 4},
        {'time': '9AM', 'pain': 6},
        {'time': '12PM', 'pain': 8},
        {'time': '3PM', 'pain': 7},
        {'time': '6PM', 'pain': 5},
        {'time': '9PM', 'pain': 4},
      ],
    },
    {
      'date': '27',
      'weekday': 'T',
      'day': 'Thursday',
      'periodDay': 2,
      'predictions': [
        {'condition': 'Back', 'severity': 'Severe'},
        {'condition': 'Knee', 'severity': 'Moderate'},
      ],
      'slots': [
        {'time': '6AM', 'pain': 3},
        {'time': '9AM', 'pain': 5},
        {'time': '12PM', 'pain': 7},
        {'time': '3PM', 'pain': 6},
        {'time': '6PM', 'pain': 4},
        {'time': '9PM', 'pain': 3},
      ],
    },
    {
      'date': '28',
      'weekday': 'F',
      'day': 'Friday',
      'periodDay': 3,
      'predictions': [
        {'condition': 'Hip', 'severity': 'Severe'},
        {'condition': 'Migraine', 'severity': 'Mild'},
      ],
      'slots': [
        {'time': '6AM', 'pain': 2},
        {'time': '9AM', 'pain': 4},
        {'time': '12PM', 'pain': 6},
        {'time': '3PM', 'pain': 5},
        {'time': '6PM', 'pain': 4},
        {'time': '9PM', 'pain': 3},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialLog != null) {
      _todaysLog = widget.initialLog;
      AppState().setCurrentLog(widget.initialLog);
    } else {
      _todaysLog = AppState().currentLog;
    }
  }

  void _navigateDay(int direction) {
    setState(() {
      _selectedDayIndex = (_selectedDayIndex + direction).clamp(0, _days.length - 1);
    });
  }

  void _handleLogSaved(SymptomLog log) {
    setState(() {
      _todaysLog = log;
      AppState().setCurrentLog(log);
    });
  }

  Widget _buildCalendarDay(String day, String weekday, bool isSelected) {
    return Container(
      width: 40,
      child: Column(
        children: [
          Text(
            weekday,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFC857) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(String condition, String severity) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PredictionDetailScreen(
              condition: condition,
              severity: severity,
              selectedDay: _days[_selectedDayIndex],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              condition,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: severity.toLowerCase() == 'severe' 
                    ? const Color(0xFFFFE5E5)
                    : severity.toLowerCase() == 'moderate'
                        ? const Color(0xFFFFF3D6)
                        : const Color(0xFFE5FFE9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                severity,
                style: TextStyle(
                  fontSize: 14,
                  color: severity.toLowerCase() == 'severe' 
                      ? Colors.red[700]
                      : severity.toLowerCase() == 'moderate'
                          ? Colors.orange[700]
                          : Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionGraph() {
    final selectedDay = _days[_selectedDayIndex];
    final slots = selectedDay['slots'] as List<Map<String, dynamic>>;

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pain Level Prediction',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (_selectedTime != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Time: $_selectedTime',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pain Level: ${slots.firstWhere((slot) => slot['time'] == _selectedTime)['pain']} / 10',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A73C7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < slots.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              slots[value.toInt()]['time'],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 10,
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 0,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot spot) {
                        return LineTooltipItem(
                          '',
                          const TextStyle(fontSize: 0),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                    if (event is FlPanEndEvent || event is FlTapUpEvent || event is FlLongPressEnd) {
                      setState(() {
                        _selectedTime = null;
                      });
                      return;
                    }
                    if (touchResponse?.lineBarSpots != null && touchResponse!.lineBarSpots!.isNotEmpty) {
                      final spotIndex = touchResponse.lineBarSpots![0].x.toInt();
                      if (spotIndex >= 0 && spotIndex < slots.length) {
                        setState(() {
                          _selectedTime = slots[spotIndex]['time'];
                        });
                      }
                    }
                  },
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(slots.length, (index) {
                      final slot = slots[index];
                      return FlSpot(index.toDouble(), slot['pain'].toDouble());
                    }),
                    isCurved: true,
                    color: const Color(0xFF4A73C7),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final isSelected = _selectedTime == slots[index]['time'];
                        return FlDotCirclePainter(
                          radius: isSelected ? 6 : 4,
                          color: Colors.white,
                          strokeWidth: isSelected ? 3 : 2,
                          strokeColor: const Color(0xFF4A73C7),
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF4A73C7).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogRecap() {
    if (_todaysLog == null) return const SizedBox.shrink();

    String _getSeverityEmoji(double level) {
      if (level >= 8) return '🔴';
      if (level >= 5) return '🟡';
      if (level > 0) return '🟢';
      return '';
    }

    String _getMoodEmoji() {
      final highestPain = _todaysLog!.painLevels.values.reduce((a, b) => a > b ? a : b);
      if (highestPain >= 8) return '😣';
      if (highestPain >= 5) return '😕';
      if (highestPain > 0) return '🙂';
      return '😊';
    }

    String _getInspirationMessage() {
      final highestPain = _todaysLog!.painLevels.values.reduce((a, b) => a > b ? a : b);
      if (highestPain >= 8) {
        return "Take it easy today. Every step forward matters, no matter how small.";
      } else if (highestPain >= 5) {
        return "You're handling this with grace. Remember to be kind to yourself.";
      } else if (highestPain > 0) {
        return "You're doing great! Keep listening to your body.";
      }
      return "Wonderful day! Keep up the positive momentum!";
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4A73C7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Log",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push<SymptomLog>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogSymptomsScreen(
                          selectedDate: DateTime(2024, 4, 26),
                          initialLog: _todaysLog,
                        ),
                      ),
                    );
                    if (result != null) {
                      _handleLogSaved(result);
                    }
                  },
                  icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_todaysLog!.painLevels.values.any((level) => level > 0)) ...[
                  const Text(
                    'Pain Levels',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(_todaysLog!.painLevels.entries
                    .where((entry) => entry.value > 0)
                    .map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text(
                            _getSeverityEmoji(entry.value),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${entry.key.substring(0, 1).toUpperCase()}${entry.key.substring(1)}: ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${entry.value.toInt()}/10',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: entry.value >= 8 
                                  ? Colors.red[700]
                                  : entry.value >= 5
                                      ? Colors.orange[700]
                                      : Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ))),
                  const SizedBox(height: 12),
                ],
                if (_todaysLog!.symptoms.isNotEmpty) ...[
                  const Text(
                    'Symptoms',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _todaysLog!.symptoms.map((symptom) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        symptom,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_todaysLog!.triggers.isNotEmpty) ...[
                  const Text(
                    'Triggers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _todaysLog!.triggers.map((trigger) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC857),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        trigger,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_todaysLog!.activities?.isNotEmpty == true) ...[
                  const Text(
                    'Activities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _todaysLog!.activities!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_todaysLog!.notes?.isNotEmpty == true) ...[
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _todaysLog!.notes!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getMoodEmoji(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _getInspirationMessage(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyPredictionTable() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Pain Level Predictions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.0), // Time
              1: FlexColumnWidth(1.2), // Weather
              2: FlexColumnWidth(0.8), // Pain
              3: FlexColumnWidth(2.0), // Impacts
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      'Weather',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      'Pain',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      'Impacts',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Morning',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wb_sunny, size: 20, color: Colors.orange),
                          SizedBox(width: 4),
                          Text('14°', style: TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildPainIndicator(5),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather: Low',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Period: High',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Allergy: Medium',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Afternoon',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.cloud, size: 20, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('18°', style: TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildPainIndicator(7),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather: Medium',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Period: High',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Allergy: High',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Evening',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.cloud_queue, size: 20, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('15°', style: TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildPainIndicator(6),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather: Medium',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Period: Medium',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Allergy: Low',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Night',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.nightlight_round, size: 20, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text('12°', style: TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildPainIndicator(4),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather: Low',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Period: Medium',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Allergy: Low',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPainIndicator(int level) {
    Color color;
    if (level >= 8) {
      color = Colors.red[700]!;
    } else if (level >= 5) {
      color = Colors.orange[700]!;
    } else {
      color = Colors.green[700]!;
    }

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            color: color.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              level.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyForecast() {
    final List<Map<String, dynamic>> weeklyData = [
      {
        'day': 'Today',
        'date': '26th Apr.',
        'hasWarning': true,
        'slots': [
          {'time': 'Night', 'pain': 3},
          {'time': 'Morn', 'pain': 5},
          {'time': 'Noon', 'pain': 7},
          {'time': 'Eve', 'pain': 4}
        ],
        'weather': {'icon': Icons.wb_sunny, 'temp': '14°'},
        'impacts': {
          'weather': 'Low',
          'period': 'High',
          'allergy': 'Medium'
        }
      },
      {
        'day': 'Thursday',
        'date': '27th Apr.',
        'hasWarning': true,
        'slots': [
          {'time': 'Night', 'pain': 4},
          {'time': 'Morn', 'pain': 6},
          {'time': 'Noon', 'pain': 8},
          {'time': 'Eve', 'pain': 5}
        ],
        'weather': {'icon': Icons.wb_cloudy, 'temp': '15°'},
        'impacts': {
          'weather': 'Medium',
          'period': 'High',
          'allergy': 'High'
        }
      },
      {
        'day': 'Friday',
        'date': '28th Apr.',
        'hasWarning': true,
        'slots': [
          {'time': 'Night', 'pain': 5},
          {'time': 'Morn', 'pain': 7},
          {'time': 'Noon', 'pain': 8},
          {'time': 'Eve', 'pain': 6}
        ],
        'weather': {'icon': Icons.cloud, 'temp': '15°'},
        'impacts': {
          'weather': 'Medium',
          'period': 'Medium',
          'allergy': 'Low'
        }
      },
      {
        'day': 'Saturday',
        'date': '29th Apr.',
        'hasWarning': true,
        'slots': [
          {'time': 'Night', 'pain': 4},
          {'time': 'Morn', 'pain': 6},
          {'time': 'Aft', 'pain': 7},
          {'time': 'Eve', 'pain': 5}
        ],
        'weather': {'icon': Icons.cloud, 'temp': '12°'},
        'impacts': {
          'weather': 'Low',
          'period': 'Medium',
          'allergy': 'Low'
        }
      }
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weekly Forecast',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _showForecastGraph = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: !_showForecastGraph ? const Color(0xFFE3F2FD) : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Table',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _showForecastGraph = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _showForecastGraph ? const Color(0xFFE3F2FD) : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Graph',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!_showForecastGraph) ...[
            Container(
              width: double.infinity,
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.0),  // Day column
                  1: FlexColumnWidth(1.0),  // Morning
                  2: FlexColumnWidth(1.0),  // Afternoon
                  3: FlexColumnWidth(1.0),  // Evening
                  4: FlexColumnWidth(1.0),  // Night
                  5: FlexColumnWidth(1.5),  // Weather
                  6: FlexColumnWidth(3.0),  // Impacts
                },
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                    ),
                    children: [
                      // Day column header
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Morning column header
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth < 40
                                ? const Icon(Icons.wb_twilight, size: 16)
                                : Text(
                                    constraints.maxWidth < 60 ? 'Morn' : 'Morning',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  );
                          },
                        ),
                      ),
                      // Afternoon column header
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth < 40
                                ? const Icon(Icons.wb_sunny, size: 16)
                                : Text(
                                    constraints.maxWidth < 70 ? 'Noon' : 'Afternoon',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  );
                          },
                        ),
                      ),
                      // Evening column header
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth < 40
                                ? const Icon(Icons.nights_stay, size: 16)
                                : Text(
                                    constraints.maxWidth < 65 ? 'Eve' : 'Evening',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  );
                          },
                        ),
                      ),
                      // Night column header
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth < 40
                                ? const Icon(Icons.nightlight, size: 16)
                                : const Text(
                                    'Night',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  );
                          },
                        ),
                      ),
                      // Weather column header
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth <= 60
                                ? const Icon(Icons.wb_sunny_outlined, size: 16)
                                : const Text(
                                    'Weather',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  );
                          },
                        ),
                      ),
                      // Impacts column header
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Impacts',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...weeklyData.map((day) => TableRow(
                    children: [
                      // Day and date column
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              day['day'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              day['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Morning pain
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildPainIndicator(day['slots'][1]['pain']),
                      ),
                      // Afternoon pain
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildPainIndicator(day['slots'][2]['pain']),
                      ),
                      // Evening pain
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildPainIndicator(day['slots'][3]['pain']),
                      ),
                      // Night pain
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildPainIndicator(day['slots'][0]['pain']),
                      ),
                      // Weather
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return constraints.maxWidth <= 40
                                ? Icon(
                                    day['weather']['icon'],
                                    size: 20,
                                    color: Colors.grey[600],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        day['weather']['icon'],
                                        size: 20,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        day['weather']['temp'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                      ),
                      // Impacts
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weather: ${day['impacts']['weather']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _getImpactColor(day['impacts']['weather']),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Period: ${day['impacts']['period']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _getImpactColor(day['impacts']['period']),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Allergy: ${day['impacts']['allergy']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _getImpactColor(day['impacts']['allergy']),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )).toList(),
                ],
              ),
            ),
          ] else ...[
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 2,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final int dayIndex = value.toInt() ~/ 4;
                          final int timeIndex = value.toInt() % 4;
                          if (dayIndex < weeklyData.length) {
                            final times = ['Morning', 'Afternoon', 'Evening', 'Night'];
                            final icons = [
                              Icons.wb_twilight,  // Morning
                              Icons.wb_sunny,     // Afternoon
                              Icons.nights_stay,  // Evening
                              Icons.nightlight,   // Night
                            ];
                            return Column(
                              children: [
                                Icon(
                                  icons[timeIndex],
                                  size: 16,
                                  color: Colors.black54,
                                ),
                                if (timeIndex == 1) // Show day name under Afternoon
                                  Text(
                                    '${weeklyData[dayIndex]['day']}, ${weeklyData[dayIndex]['date']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  minX: 0,
                  maxX: weeklyData.length * 4 - 1,
                  minY: 0,
                  maxY: 10,
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.white,
                      tooltipRoundedRadius: 8,
                      tooltipBorder: BorderSide(color: Colors.grey[300]!),
                      tooltipPadding: const EdgeInsets.all(12),
                      tooltipMargin: 16,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((LineBarSpot spot) {
                          final dayIndex = spot.x.toInt() ~/ 4;
                          final timeIndex = spot.x.toInt() % 4;
                          final day = weeklyData[dayIndex];
                          final times = ['Morning', 'Afternoon', 'Evening', 'Night'];
                          final time = times[timeIndex];

                          return LineTooltipItem(
                            '$time\n'
                            'Pain: ${spot.y.toInt()}/10\n'
                            'Weather: ${day['weather']['temp']}\n'
                            'Impacts:\n'
                            '${day['impacts']['weather'] == 'High' ? '🔴' : day['impacts']['weather'] == 'Medium' ? '🟡' : '🟢'} Weather: ${day['impacts']['weather']}\n'
                            '${day['impacts']['period'] == 'High' ? '🔴' : day['impacts']['period'] == 'Medium' ? '🟡' : '🟢'} Period: ${day['impacts']['period']}\n'
                            '${day['impacts']['allergy'] == 'High' ? '🔴' : day['impacts']['allergy'] == 'Medium' ? '🟡' : '🟢'} Allergy: ${day['impacts']['allergy']}',
                            TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              height: 1.5,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(weeklyData.length * 4, (index) {
                        final dayIndex = index ~/ 4;
                        final timeIndex = index % 4;
                        final day = weeklyData[dayIndex];
                        final painLevel = day['slots'][timeIndex]['pain'].toDouble();
                        return FlSpot(index.toDouble(), painLevel);
                      }),
                      isCurved: true,
                      color: const Color(0xFF4A73C7),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: const Color(0xFF4A73C7),
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF4A73C7).withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Morning', Colors.orange[300]!),
                  const SizedBox(width: 16),
                  _buildLegendItem('Afternoon', Colors.orange[700]!),
                  const SizedBox(width: 16),
                  _buildLegendItem('Evening', Colors.blue[300]!),
                  const SizedBox(width: 16),
                  _buildLegendItem('Night', Colors.blue[700]!),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    final IconData icon = label == 'Morning' 
        ? Icons.wb_twilight
        : label == 'Afternoon'
            ? Icons.wb_sunny
            : label == 'Evening'
                ? Icons.nights_stay
                : Icons.nightlight;

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.black54,
        ),
        const SizedBox(width: 4),
        Text(
          ': $label',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return Colors.red[700]!;
      case 'medium':
        return Colors.orange[700]!;
      case 'low':
        return Colors.green[700]!;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = _days[_selectedDayIndex];
    final isToday = _selectedDayIndex == 2; // Wednesday is today

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A73C7),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Daily Prediction',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _selectedDayIndex > 0 
                          ? () {
                              _navigateDay(-1);
                              setState(() => _selectedTime = null);
                            }
                          : null,
                      color: _selectedDayIndex > 0 
                          ? Colors.black54
                          : Colors.black26,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          _days.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDayIndex = index;
                                _selectedTime = null;
                              });
                            },
                            child: _buildCalendarDay(
                              _days[index]['date'],
                              _days[index]['weekday'],
                              index == _selectedDayIndex,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _selectedDayIndex < _days.length - 1 
                          ? () {
                              _navigateDay(1);
                              setState(() => _selectedTime = null);
                            }
                          : null,
                      color: _selectedDayIndex < _days.length - 1 
                          ? Colors.black54
                          : Colors.black26,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (selectedDay['periodDay'] != 'No Period') Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Period: Day ${selectedDay['periodDay']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          if (selectedDay['periodDay'] != 'No Period') const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              isToday && _todaysLog != null
                                  ? 'Thank you for logging your day!'
                                  : 'Remember to log your day!',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (!(isToday && _todaysLog != null)) Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3D6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Remember to log your day to help us provide more accurate predictions!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (isToday && _todaysLog != null) _buildLogRecap(),
                Text(
                  isToday ? "Today's Predictions" : "${selectedDay['day']}'s Predictions",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                if (!isToday) _buildPredictionGraph(),
                if (isToday) ...[
                  _buildWeeklyPredictionTable(),
                  const SizedBox(height: 24),
                ],
                ...selectedDay['predictions'].map<Widget>((prediction) => 
                  _buildPredictionCard(
                    prediction['condition'],
                    prediction['severity'],
                  ),
                ).toList(),
                if (isToday) _buildWeeklyForecast(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF4A73C7),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Daily',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<SymptomLog>(
            context,
            MaterialPageRoute(
              builder: (context) => LogSymptomsScreen(
                selectedDate: DateTime(2024, 4, 26),
                initialLog: _todaysLog,
              ),
            ),
          );
          if (result != null) {
            _handleLogSaved(result);
          }
        },
        backgroundColor: const Color(0xFFFFC857),
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
    );
  }
} 