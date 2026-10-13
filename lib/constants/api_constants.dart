import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConstants {
  // Tự động nhận diện nền tảng:
  // - Android Emulator: 10.0.2.2:3000
  // - iOS Simulator / macOS / Web: localhost:3000
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  // Endpoints
  static const String health = '/health';
  static const String signup = '/api/signup';
  static const String login = '/api/login';
  static const String rankings = '/api/rankings';
  static const String exercises = '/api/exercises';
  static const String recommendations = '/api/recommendations';
  static const String exerciseLogs = '/api/exercise-logs';
  static const String symptomLogs = '/api/symptom-logs';
  static const String smokeLogs = '/api/smoke-logs';
  static const String profileHealth = '/api/profile/health';
  static const String coach = '/api/coach';
  static const String coachHistory = '/api/coach/history';
  static const String pointSummary = '/api/points/summary';
  static const String claimMilestones = '/api/points/claim-milestones';
}

