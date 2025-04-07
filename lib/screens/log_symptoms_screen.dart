import 'package:flutter/material.dart';
import '../models/symptom_log.dart';

class LogSymptomsScreen extends StatefulWidget {
  final DateTime selectedDate;
  final SymptomLog? initialLog;

  const LogSymptomsScreen({
    super.key,
    required this.selectedDate,
    this.initialLog,
  });

  @override
  State<LogSymptomsScreen> createState() => _LogSymptomsScreenState();
}

class _LogSymptomsScreenState extends State<LogSymptomsScreen> {
  final Map<String, double> _painLevels = {
    'migraine': 0,
    'back': 0,
    'hip': 0,
    'neck': 0,
    'knee': 0,
  };

  final List<String> _selectedSymptoms = [];
  final List<String> _selectedTriggers = [];
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<String> _symptoms = [
    'Fatigue',
    'Nausea',
    'Bloating',
    'Stiffness',
    'Anxiety',
    'Insomnia',
    'Dizziness',
    'Mood Swings',
  ];

  final List<String> _triggers = [
    'Humidity',
    'Rain',
    'Heat',
    'Period',
    'Stress',
    'Coffee',
    'Sugar',
    'Alcohol',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialLog != null) {
      _painLevels.addAll(widget.initialLog!.painLevels);
      _selectedSymptoms.addAll(widget.initialLog!.symptoms);
      _selectedTriggers.addAll(widget.initialLog!.triggers);
      _activitiesController.text = widget.initialLog!.activities ?? '';
      _notesController.text = widget.initialLog!.notes ?? '';
    }
  }

  void _saveLog() {
    final log = SymptomLog(
      date: widget.selectedDate,
      painLevels: Map<String, double>.from(_painLevels),
      symptoms: List<String>.from(_selectedSymptoms),
      triggers: List<String>.from(_selectedTriggers),
      activities: _activitiesController.text.isNotEmpty ? _activitiesController.text : null,
      notes: _notesController.text.isNotEmpty ? _notesController.text : null,
    );
    Navigator.pop(context, log);
  }

  Widget _buildPainSlider(String condition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How was your ${condition.toLowerCase()} pain today?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF4A73C7),
                  inactiveTrackColor: Colors.grey[200],
                  thumbColor: const Color(0xFF4A73C7),
                  overlayColor: const Color(0xFF4A73C7).withOpacity(0.2),
                ),
                child: Slider(
                  value: _painLevels[condition.toLowerCase()]!,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _painLevels[condition.toLowerCase()] = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              _painLevels[condition.toLowerCase()]!.toInt().toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSymptomChip(String symptom) {
    final bool isSelected = _selectedSymptoms.contains(symptom);
    return FilterChip(
      label: Text(
        symptom,
        style: TextStyle(
          color: isSelected ? Colors.black87 : Colors.black54,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedSymptoms.add(symptom);
          } else {
            _selectedSymptoms.remove(symptom);
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFF5F6FA),
      checkmarkColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildTriggerChip(String trigger) {
    final bool isSelected = _selectedTriggers.contains(trigger);
    return FilterChip(
      label: Text(
        trigger,
        style: TextStyle(
          color: isSelected ? Colors.black87 : Colors.black54,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedTriggers.add(trigger);
          } else {
            _selectedTriggers.remove(trigger);
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFFFC857),
      checkmarkColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          "Log Today's Symptoms",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Wednesday, April 26',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Pain Levels',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...['Migraine', 'Back', 'Hip', 'Neck', 'Knee'].map(_buildPainSlider),
          const Text(
            'Symptoms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _symptoms.map(_buildSymptomChip).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Triggers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _triggers.map(_buildTriggerChip).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Activities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _activitiesController,
            decoration: InputDecoration(
              hintText: 'What did you do today? (e.g., Running, Swimming)',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF4A73C7)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Notes (Optional)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Anything else you want to add?',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF4A73C7)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _saveLog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A73C7),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save Log',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 