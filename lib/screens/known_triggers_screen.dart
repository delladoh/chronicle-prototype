import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'helpful_tip_screen.dart';

class KnownTriggersScreen extends StatefulWidget {
  const KnownTriggersScreen({super.key});

  @override
  State<KnownTriggersScreen> createState() => _KnownTriggersScreenState();
}

class _KnownTriggersScreenState extends State<KnownTriggersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, bool> _selectedTriggers = {
    'Rain': false,
    'Humidity': false,
    'Cold': false,
    'Heat': false,
    'Pressure Changes': false,
    'Caffeine': false,
    'Alcohol': false,
    'Dairy': false,
    'Processed Foods': false,
    'Stress': false,
    'Sleep Changes': false,
    'Exercise': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get _hasSelectedTriggers => _selectedTriggers.values.contains(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.text,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Known Triggers',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A73C7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Which triggers are you currently aware of?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF4A73C7),
                unselectedLabelColor: Colors.black54,
                indicatorColor: const Color(0xFF4A73C7),
                tabs: const [
                  Tab(text: 'Weather'),
                  Tab(text: 'Food & Drink'),
                  Tab(text: 'Health'),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTriggerGrid([
                      'Rain',
                      'Humidity',
                      'Cold',
                      'Heat',
                      'Pressure Changes',
                    ]),
                    _buildTriggerGrid([
                      'Caffeine',
                      'Alcohol',
                      'Dairy',
                      'Processed Foods',
                    ]),
                    _buildTriggerGrid([
                      'Stress',
                      'Sleep Changes',
                      'Exercise',
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _hasSelectedTriggers
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpfulTipScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A73C7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTriggerGrid(List<String> triggers) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: triggers.map((trigger) {
        return FilterChip(
          label: Text(trigger),
          selected: _selectedTriggers[trigger] ?? false,
          onSelected: (selected) {
            setState(() {
              _selectedTriggers[trigger] = selected;
            });
          },
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF4A73C7).withOpacity(0.2),
          checkmarkColor: const Color(0xFF4A73C7),
          side: BorderSide(
            color: (_selectedTriggers[trigger] ?? false)
                ? const Color(0xFF4A73C7)
                : Colors.grey.shade400,
          ),
          labelStyle: TextStyle(
            color: (_selectedTriggers[trigger] ?? false)
                ? const Color(0xFF4A73C7)
                : Colors.black87,
          ),
        );
      }).toList(),
    );
  }
} 