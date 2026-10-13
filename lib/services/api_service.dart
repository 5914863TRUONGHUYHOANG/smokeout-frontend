import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../models/user_model.dart';
import '../models/ranking_model.dart';
import '../models/recommendation_model.dart';
import '../models/coach_model.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();
  ApiService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  final ValueNotifier<UserModel?> userNotifier = ValueNotifier<UserModel?>(null);

  // Headers helper
  Map<String, String> _headers() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_currentUser != null) {
      headers['x-user-id'] = _currentUser!.userId.toString();
    }
    return headers;
  }

  // Khởi tạo từ SharedPreferences
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('saved_user');
    if (userJson != null) {
      try {
        _currentUser = UserModel.fromJson(jsonDecode(userJson));
        userNotifier.value = _currentUser;
      } catch (e) {
        debugPrint('Error restoring user session: $e');
      }
    }
  }

  Future<void> _saveUser(UserModel user) async {
    _currentUser = user;
    userNotifier.value = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_user', jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    _currentUser = null;
    userNotifier.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_user');
  }

  // Health Check
  Future<bool> checkHealth() async {
    try {
      final res = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.health}'));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // Đăng ký (Signup)
  Future<UserModel> signup({
    required String email,
    required String password,
    required String nickname,
    int dailyCigaretteCount = 10,
    int packPrice = 4500,
    String fitnessLevel = 'BEGINNER',
  }) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.signup}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email.trim().toLowerCase(),
        'password': password,
        'nickname': nickname.trim(),
        'dailyCigaretteCount': dailyCigaretteCount,
        'packPrice': packPrice,
        'fitnessLevel': fitnessLevel,
      }),
    );

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200 || res.statusCode == 201) {
      final user = UserModel.fromJson(data['data']);
      await _saveUser(user);
      return user;
    } else {
      throw Exception(data['message'] ?? data['error'] ?? '회원가입 실패');
    }
  }

  // Đăng nhập (Login)
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email.trim().toLowerCase(),
        'password': password,
      }),
    );

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200) {
      final user = UserModel.fromJson(data['data']);
      await _saveUser(user);
      return user;
    } else {
      throw Exception(data['message'] ?? data['error'] ?? '로그인 실패');
    }
  }

  // Bảng xếp hạng (Rankings)
  Future<List<RankingItem>> getRankings({int limit = 50}) async {
    final res = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.rankings}?limit=$limit'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      final List list = jsonDecode(utf8.decode(res.bodyBytes));
      return list.map((item) => RankingItem.fromJson(item)).toList();
    } else {
      throw Exception('랭킹을 불러오는데 실패했습니다.');
    }
  }

  // Danh sách bài tập
  Future<List<Exercise>> getExercises() async {
    final res = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.exercises}'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      final List list = jsonDecode(utf8.decode(res.bodyBytes));
      return list.map((item) => Exercise.fromJson(item)).toList();
    } else {
      throw Exception('운동 목록을 불러오는데 실패했습니다.');
    }
  }

  // Đề xuất AI (Recommendations)
  Future<RecommendationResult> getRecommendations({
    required String symptomType,
    required int cravingLevel,
    int availableMinutes = 15,
    String location = 'ANY',
    bool hasEquipment = false,
  }) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.recommendations}'),
      headers: _headers(),
      body: jsonEncode({
        'symptomType': symptomType,
        'cravingLevel': cravingLevel,
        'availableMinutes': availableMinutes,
        'location': location,
        'hasEquipment': hasEquipment,
      }),
    );

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return RecommendationResult.fromJson(data);
    } else {
      throw Exception(data['message'] ?? data['error'] ?? 'AI 추천 생성 실패');
    }
  }

  // Ghi nhật ký triệu chứng thèm thuốc
  Future<int> logSymptom({
    required String symptomType,
    required int intensityBefore,
  }) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.symptomLogs}'),
      headers: _headers(),
      body: jsonEncode({
        'symptomType': symptomType,
        'intensityBefore': intensityBefore,
      }),
    );

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 201) {
      return data['symptomLogId'] ?? 0;
    } else {
      throw Exception('증상 기록 실패');
    }
  }

  // Ghi nhật ký hoàn thành bài tập
  Future<void> logExercise({
    required int exerciseId,
    required int durationCompleted,
    int? recommendationId,
    int? symptomLogId,
    int? intensityAfter,
  }) async {
    final now = DateTime.now();
    final startedAt = now.subtract(Duration(minutes: durationCompleted));
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.exerciseLogs}'),
      headers: _headers(),
      body: jsonEncode({
        'exerciseId': exerciseId,
        'startedAt': startedAt.toUtc().toIso8601String(),
        'completedAt': now.toUtc().toIso8601String(),
        'durationCompleted': durationCompleted,
        'recommendationId': ?recommendationId,
        'symptomLogId': ?symptomLogId,
        'intensityAfter': ?intensityAfter,
      }),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      final data = jsonDecode(utf8.decode(res.bodyBytes));
      throw Exception(data['message'] ?? '운동 기록 실패');
    }
  }

  // Chat AI Coach
  Future<String> sendCoachMessage(String message) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.coach}'),
      headers: _headers(),
      body: jsonEncode({'message': message}),
    );

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200) {
      return data['reply'] ?? '';
    } else {
      throw Exception(data['message'] ?? data['error'] ?? 'AI 코치 응답 실패');
    }
  }

  // Lịch sử Chat AI Coach
  Future<List<CoachMessage>> getCoachHistory() async {
    final res = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.coachHistory}'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      final List list = jsonDecode(utf8.decode(res.bodyBytes));
      return list.map((item) => CoachMessage.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  // Tổng hợp điểm số
  Future<Map<String, dynamic>> getPointSummary() async {
    final res = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.pointSummary}'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes));
    }
    return {};
  }

  // Nhận thưởng mốc ngày bỏ thuốc
  Future<Map<String, dynamic>> claimMilestones() async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.claimMilestones}'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      return jsonDecode(utf8.decode(res.bodyBytes));
    }
    return {};
  }

  // Cập nhật tình trạng sức khỏe
  Future<void> updateHealthProfile({
    required String fitnessLevel,
    List<String> healthFlags = const [],
  }) async {
    final res = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.profileHealth}'),
      headers: _headers(),
      body: jsonEncode({
        'fitnessLevel': fitnessLevel,
        'healthFlags': healthFlags,
      }),
    );

    if (res.statusCode == 204) {
      if (_currentUser != null) {
        await _saveUser(_currentUser!.copyWith(fitnessLevel: fitnessLevel));
      }
    } else {
      throw Exception('건강 정보 갱신 실패');
    }
  }
}

