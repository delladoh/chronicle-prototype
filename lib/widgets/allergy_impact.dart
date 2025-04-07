import 'package:flutter/material.dart';

class AllergyImpact extends StatelessWidget {
  const AllergyImpact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Allergy Impact',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),
          _buildAllergyItem(
            'Pollen',
            'Take precautions when outdoors',
            'High',
            const Color(0xFFFFF3E0),
            const Color(0xFFFF9800),
          ),
          const SizedBox(height: 24),
          _buildAllergyItem(
            'Mold',
            'Moderate levels present today',
            'Medium',
            const Color(0xFFE8F5E9),
            const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 24),
          _buildAllergyItem(
            'Dust',
            'Minimal presence detected',
            'Low',
            const Color(0xFFE3F2FD),
            const Color(0xFF2196F3),
          ),
          const SizedBox(height: 32),
          const Text(
            'Allergy Forecast',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildForecastDay('Mon', 'High'),
              _buildForecastDay('Tue', 'High'),
              _buildForecastDay('Wed', 'Medium'),
              _buildForecastDay('Thu', 'Medium'),
              _buildForecastDay('Fri', 'Low'),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              const Text(
                'Pain Impact',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFC857)),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'High',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyItem(
    String title,
    String description,
    String impact,
    Color impactColor,
    Color impactTextColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: impactColor,
            borderRadius: BorderRadius.circular(16),
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

  Widget _buildForecastDay(String day, String impact) {
    Color textColor;
    Color backgroundColor;
    switch (impact.toLowerCase()) {
      case 'high':
        textColor = const Color(0xFFFF9800);
        backgroundColor = const Color(0xFFFFF3E0);
        break;
      case 'medium':
        textColor = const Color(0xFF4CAF50);
        backgroundColor = const Color(0xFFE8F5E9);
        break;
      case 'low':
        textColor = const Color(0xFF2196F3);
        backgroundColor = const Color(0xFFE3F2FD);
        break;
      default:
        textColor = Colors.black87;
        backgroundColor = Colors.grey.shade100;
    }

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            impact,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
} 