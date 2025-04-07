import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'known_triggers_screen.dart';

class PainTypeSelectionScreen extends StatefulWidget {
  const PainTypeSelectionScreen({super.key});

  @override
  State<PainTypeSelectionScreen> createState() => _PainTypeSelectionScreenState();
}

class _PainTypeSelectionScreenState extends State<PainTypeSelectionScreen> {
  final Map<String, bool> _selectedPainTypes = {
    'Back': false,
    'Neck': false,
    'Knee': false,
    'Migraines': false,
    'Wrist': false,
    'Fibromyalgia': false,
    'Hip': false,
    'Shoulder': false,
  };

  bool get _hasSelectedPainTypes => _selectedPainTypes.values.contains(true);

  @override
  Widget build(BuildContext context) {
    final painTypes = _selectedPainTypes.keys.toList()..sort();

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
                'Pain Type Selection',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A73C7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'What kind(s) of pain will you be tracking?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: painTypes.length,
                  itemBuilder: (context, index) {
                    final painType = painTypes[index];
                    final isSelected = _selectedPainTypes[painType] ?? false;
                    
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPainTypes[painType] = !isSelected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF4A73C7) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF4A73C7) : Colors.grey.shade400,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            painType,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Text(
                'Organize alphabetically for easy reference',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _hasSelectedPainTypes
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KnownTriggersScreen(),
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
} 