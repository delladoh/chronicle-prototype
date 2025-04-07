class SymptomLog {
  final DateTime date;
  final Map<String, double> painLevels;
  final List<String> symptoms;
  final List<String> triggers;
  final String? activities;
  final String? notes;

  SymptomLog({
    required this.date,
    required this.painLevels,
    required this.symptoms,
    required this.triggers,
    this.activities,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'painLevels': painLevels,
      'symptoms': symptoms,
      'triggers': triggers,
      'activities': activities,
      'notes': notes,
    };
  }

  factory SymptomLog.fromJson(Map<String, dynamic> json) {
    return SymptomLog(
      date: DateTime.parse(json['date']),
      painLevels: Map<String, double>.from(json['painLevels']),
      symptoms: List<String>.from(json['symptoms']),
      triggers: List<String>.from(json['triggers']),
      activities: json['activities'],
      notes: json['notes'],
    );
  }
} 