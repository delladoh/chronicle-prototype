import 'symptom_log.dart';

class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  SymptomLog? _currentLog;
  
  SymptomLog? get currentLog => _currentLog;
  
  void setCurrentLog(SymptomLog? log) {
    _currentLog = log;
  }
} 