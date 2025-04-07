# Chronicle - Chronic Pain Tracker & Predictor

Chronicle is a Flutter application designed to help users track and predict their chronic pain levels based on various factors such as weather, menstrual cycle, and allergies.

## Features

- Daily pain prediction graph
- Contributing factors analysis
- Weather impact tracking
- Menstrual cycle tracking
- Allergy impact monitoring

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/chronicle.git
```

2. Navigate to the project directory:

```bash
cd chronicle
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Project Structure

- `lib/main.dart` - Main application entry point and theme configuration
- `lib/screens/` - Screen widgets (Home screen)
- `lib/widgets/` - Reusable widgets for different sections
  - Pain Prediction Chart
  - Contributing Factors
  - Weather Impact
  - Cycle Tracker
  - Allergy Impact

## Dependencies

- `fl_chart` - For creating interactive charts
- `table_calendar` - For the calendar widget
- `cupertino_icons` - iOS style icons

## Note

This is a frontend prototype with mock data. No backend integration is implemented in this version.
