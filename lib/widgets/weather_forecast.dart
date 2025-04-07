import 'package:flutter/material.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '5-Day Forecast',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildForecastDay('Mon', Icons.wb_sunny_outlined, '73°F'),
              _buildForecastDay('Tue', Icons.cloud_outlined, '75°F'),
              _buildForecastDay('Wed', Icons.cloud_outlined, '71°F'),
              _buildForecastDay('Thu', Icons.water_drop_outlined, '68°F'),
              _buildForecastDay('Fri', Icons.cloud_outlined, '70°F'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForecastDay(String day, IconData icon, String temp) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Icon(
          icon,
          color: const Color(0xFF4A73C7),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          temp,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
} 