import 'package:flutter/material.dart';

class WeatherImpact extends StatelessWidget {
  const WeatherImpact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Factors Affecting Your Pain',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Weather Impact',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherFactor(
                icon: Icons.thermostat_outlined,
                label: 'Temperature',
                value: '72',
                unit: '°F',
                impact: 'High Impact',
                impactColor: const Color(0xFFFFEBEE),
                impactTextColor: const Color(0xFFE57373),
              ),
              _buildWeatherFactor(
                icon: Icons.water_drop_outlined,
                label: 'Humidity',
                value: '65',
                unit: '%',
                impact: 'Medium Impact',
                impactColor: const Color(0xFFFFF8E1),
                impactTextColor: const Color(0xFFFFB74D),
              ),
              _buildWeatherFactor(
                icon: Icons.speed_outlined,
                label: 'Pressure',
                value: '1015',
                unit: 'hPa',
                impact: 'Low Impact',
                impactColor: const Color(0xFFE8F5E9),
                impactTextColor: const Color(0xFF81C784),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherFactor({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required String impact,
    required Color impactColor,
    required Color impactTextColor,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: const Color(0xFF4A73C7),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: impactColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            impact,
            style: TextStyle(
              fontSize: 12,
              color: impactTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
} 