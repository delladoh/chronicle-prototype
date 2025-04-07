import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/pain_prediction_chart.dart';
import '../widgets/contributing_factors.dart';
import '../widgets/weather_impact.dart';
import '../widgets/weather_forecast.dart';
import '../widgets/cycle_tracker.dart';
import '../widgets/allergy_impact.dart';
import 'welcome_screen.dart';
import 'daily_screen.dart';
import 'log_symptoms_screen.dart';
import '../models/symptom_log.dart';
import '../models/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleSignOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A73C7),
        elevation: 0,
        title: const Text(
          'Chronicle',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onSelected: (value) {
              if (value == 'signout') {
                _handleSignOut(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'signout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.black87),
                    SizedBox(width: 8),
                    Text('Sign Out'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                PainPredictionChart(),
                SizedBox(height: 24),
                ContributingFactors(),
                SizedBox(height: 24),
                WeatherImpact(),
                SizedBox(height: 24),
                WeatherForecast(),
                SizedBox(height: 24),
                CycleTracker(),
                SizedBox(height: 24),
                AllergyImpact(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF4A73C7),
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyScreen(
                  initialLog: AppState().currentLog,
                ),
              ),
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
              ),
            ),
          );
          if (result != null) {
            AppState().setCurrentLog(result);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DailyScreen(initialLog: result),
              ),
            );
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