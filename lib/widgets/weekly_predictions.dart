import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyPredictions extends StatefulWidget {
  const WeeklyPredictions({super.key});

  @override
  State<WeeklyPredictions> createState() => _WeeklyPredictionsState();
}

class _WeeklyPredictionsState extends State<WeeklyPredictions> {
  bool _showGraph = false;
  String? _selectedTime;

  final List<Map<String, dynamic>> _timeSlots = [
    {'time': 'Morning', 'weather': 'Sunny', 'temp': '14°', 'pain': 5, 'weather_impact': 'Low', 'period_impact': 'High', 'allergy_impact': 'Medium'},
    {'time': 'Afternoon', 'weather': 'Partly Cloudy', 'temp': '18°', 'pain': 7, 'weather_impact': 'Medium', 'period_impact': 'High', 'allergy_impact': 'High'},
    {'time': 'Evening', 'weather': 'Cloudy', 'temp': '15°', 'pain': 6, 'weather_impact': 'Medium', 'period_impact': 'Medium', 'allergy_impact': 'Low'},
    {'time': 'Night', 'weather': 'Clear', 'temp': '12°', 'pain': 4, 'weather_impact': 'Low', 'period_impact': 'Medium', 'allergy_impact': 'Low'},
  ];

  final List<Map<String, dynamic>> _weekData = [
    {'day': 'Monday', 'slots': [
      {'time': '6AM', 'pain': 2},
      {'time': '9AM', 'pain': 4},
      {'time': '12PM', 'pain': 7},
      {'time': '3PM', 'pain': 8},
      {'time': '6PM', 'pain': 6},
      {'time': '9PM', 'pain': 5},
    ]},
    {'day': 'Tuesday', 'slots': [
      {'time': '6AM', 'pain': 3},
      {'time': '9AM', 'pain': 5},
      {'time': '12PM', 'pain': 6},
      {'time': '3PM', 'pain': 7},
      {'time': '6PM', 'pain': 5},
      {'time': '9PM', 'pain': 4},
    ]},
    {'day': 'Wednesday', 'slots': [
      {'time': '6AM', 'pain': 4},
      {'time': '9AM', 'pain': 6},
      {'time': '12PM', 'pain': 8},
      {'time': '3PM', 'pain': 7},
      {'time': '6PM', 'pain': 5},
      {'time': '9PM', 'pain': 4},
    ]},
    {'day': 'Thursday', 'slots': [
      {'time': '6AM', 'pain': 3},
      {'time': '9AM', 'pain': 5},
      {'time': '12PM', 'pain': 7},
      {'time': '3PM', 'pain': 6},
      {'time': '6PM', 'pain': 4},
      {'time': '9PM', 'pain': 3},
    ]},
    {'day': 'Friday', 'slots': [
      {'time': '6AM', 'pain': 2},
      {'time': '9AM', 'pain': 4},
      {'time': '12PM', 'pain': 6},
      {'time': '3PM', 'pain': 5},
      {'time': '6PM', 'pain': 4},
      {'time': '9PM', 'pain': 3},
    ]},
  ];

  Widget _buildTableView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: const [
                      Icon(Icons.wb_sunny_outlined, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Weather',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Pain',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Impacts',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._timeSlots.map((slot) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    slot['time'],
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(
                        slot['weather'] == 'Sunny' 
                            ? Icons.wb_sunny
                            : slot['weather'] == 'Partly Cloudy'
                                ? Icons.wb_cloudy
                                : slot['weather'] == 'Cloudy'
                                    ? Icons.cloud
                                    : Icons.nightlight_round,
                        size: 20,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        slot['temp'],
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: slot['pain'] >= 7
                              ? Colors.red[100]
                              : slot['pain'] >= 5
                                  ? Colors.orange[100]
                                  : Colors.green[100],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            slot['pain'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: slot['pain'] >= 7
                                  ? Colors.red[700]
                                  : slot['pain'] >= 5
                                      ? Colors.orange[700]
                                      : Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImpactIndicator('Weather', slot['weather_impact']),
                      const SizedBox(height: 4),
                      _buildImpactIndicator('Period', slot['period_impact']),
                      const SizedBox(height: 4),
                      _buildImpactIndicator('Allergy', slot['allergy_impact']),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildImpactIndicator(String label, String impact) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: impact == 'High'
                ? Colors.red[400]
                : impact == 'Medium'
                    ? Colors.orange[400]
                    : Colors.green[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$label: $impact',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildGraphView() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
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
                    'Pain Level: ${_weekData[2]['slots'].firstWhere((slot) => slot['time'] == _selectedTime)['pain']} / 10',
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
                        final slots = _weekData[2]['slots'];
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
                    getTooltipItems: (touchedSpots) => [],
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
                      final slots = _weekData[2]['slots'];
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
                    spots: List.generate(_weekData[2]['slots'].length, (index) {
                      final slot = _weekData[2]['slots'][index];
                      return FlSpot(index.toDouble(), slot['pain'].toDouble());
                    }),
                    isCurved: true,
                    color: const Color(0xFF4A73C7),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final isSelected = _selectedTime == _weekData[2]['slots'][index]['time'];
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _showGraph = false;
                          _selectedTime = null;
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: !_showGraph ? const Color(0xFFE3F2FD) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Table',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _showGraph = true;
                          _selectedTime = null;
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _showGraph ? const Color(0xFFE3F2FD) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Graph',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _showGraph ? _buildGraphView() : _buildTableView(),
      ],
    );
  }
} 