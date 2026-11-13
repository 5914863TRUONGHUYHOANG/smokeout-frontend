import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exercise_dialog.dart';
import 'exercise_detail.dart';

const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
const Color card = Color.fromRGBO(253, 253, 246, 1.0);
const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
const Color green = Color.fromRGBO(91, 126, 61, 1.0);
const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
const Color litGreen = Color(0xFFEEF2DE);
const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);
const Color textGray = Color.fromRGBO(95, 95, 85, 1.0);

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  double cravingLevel = 3; // 탭을 전환해도 IndexedStack이 상태를 유지
  int selectedDuration = 0;
  // 테마 색상

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F7F0),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cream,
        elevation: 0,

        toolbarHeight: 130,
        titleSpacing: 0,

        title: Stack(
          children: [
            Image.asset(
              'assets/SmokeOut_exercise.png',
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
            ),

            Positioned(
              left: 25,
              top: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        '운동',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: darkGreen,
                        ),
                      ),
                      const Icon(Icons.eco, color: green, size: 22),
                    ],
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'AI가 도와주는 맞춤형 운동',
                    style: TextStyle(fontSize: 12, color: textGray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 운동 화면 본문
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: card,
                          border: Border.all(color: borderGreen, width: 1.5),
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '지금 나에게 맞는 운동을 찾아보세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: darkGreen,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // 욕구 강도
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Row(
                                      children: [
                                        Text(
                                          '욕구 강도',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: darkGreen,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          '(0~10)',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: textGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              cravingLevel.toInt().toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' / ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              '10',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),

                                Slider(
                                  min: 0,
                                  value: cravingLevel,
                                  max: 10,
                                  divisions: 10,
                                  onChanged: (double newValue) {
                                    debugPrint('욕구 강도 선택됨: ${newValue.toInt()}');
                                    setState(() {
                                      cravingLevel = newValue;
                                    });
                                  },
                                ),

                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('0'),
                                      Text('1'),
                                      Text('2'),
                                      Text('3'),
                                      Text('4'),
                                      Text('5'),
                                      Text('6'),
                                      Text('7'),
                                      Text('8'),
                                      Text('9'),
                                      Text('10'),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // 운동 시간
                            Row(
                              children: [
                                const Text(
                                  '운동 시간',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: darkGreen,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: SegmentedButton<int>(
                                    segments: const [
                                      ButtonSegment(
                                        value: 0,
                                        label: Text('전체'),
                                      ),
                                      ButtonSegment(
                                        value: 5,
                                        label: Text('5분'),
                                      ),
                                      ButtonSegment(
                                        value: 10,
                                        label: Text('10분'),
                                      ),
                                      ButtonSegment(
                                        value: 15,
                                        label: Text('15분'),
                                      ),
                                      ButtonSegment(
                                        value: 30,
                                        label: Text('30분'),
                                      ),
                                    ],

                                    selected: {selectedDuration},

                                    onSelectionChanged:
                                        (Set<int> newSelection) {
                                      debugPrint('운동 시간 선택됨: $newSelection');
                                      setState(() {
                                        selectedDuration = newSelection.first;
                                      });
                                    },

                                    showSelectedIcon: false,

                                    // 선택 버튼 디자인
                                    style: ButtonStyle(
                                      textStyle: WidgetStateProperty.all(
                                        const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      foregroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            return states.contains(
                                                  WidgetState.selected,
                                                )
                                                ? Colors.white
                                                : darkGreen;
                                          }),

                                      backgroundColor:
                                          WidgetStateProperty.resolveWith((
                                            states,
                                          ) {
                                            return states.contains(
                                                  WidgetState.selected,
                                                )
                                                ? green
                                                : const Color(0xFFFDFDF6);
                                          }),

                                      side: WidgetStateProperty.all(
                                        const BorderSide(color: borderGreen),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // 운동 추천 버튼
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  // 화면에서 선택한 값을 이 시점에 확정합니다.
                                  final level = cravingLevel;
                                  final duration = selectedDuration;

                                  showDialog<void>(
                                    context: context,
                                    builder: (context) {
                                      return ExerciseRecommendDialog(
                                        cravingLevel: level,
                                        selectedDuration: duration,
                                        // 팝업은 화면만 담당하고, 서버 통신은
                                        // 이 파일의 ExerciseApi에서 처리합니다.
                                        loadRecommendations: () => ExerciseApi.recommend(
                                          cravingLevel: level,
                                          selectedDuration: duration,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: darkGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                    child: Text(
                                      '맞춤 운동 추천받기',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ========================================
// 운동 추천 API 통신 (기존 exercise_api.dart 통합)
// ========================================
/// 실제 서버 추천을 사용합니다. 프론트에 하드코딩된 운동 목록은 없습니다.
/// 서버 URL은 --dart-define=API_BASE_URL=http://localhost:3000 로 지정할 수 있습니다.
/// 로그인 성공 시 ExerciseApi.setUserId(loginResponseUserId) 를 호출하세요.
class ExerciseApi {
  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const String _developmentUserId = String.fromEnvironment(
    'API_USER_ID',
    defaultValue: '',
  );

  static String? _signedInUserId;

  static void setUserId(Object userId) {
    final id = userId.toString().trim();
    if (!RegExp(r'^[1-9]\d*$').hasMatch(id)) {
      throw ArgumentError('로그인 결과의 userId는 숫자여야 합니다.');
    }
    _signedInUserId = id;
  }

  static void clearUserId() => _signedInUserId = null;

  static String get _baseUrl =>
      _configuredBaseUrl.replaceFirst(RegExp(r'/$'), '');

  static Map<String, String> get _headers {
    final id = (_signedInUserId ?? _developmentUserId).trim();
    if (!RegExp(r'^[1-9]\d*$').hasMatch(id)) {
      throw const ExerciseApiException(
        '로그인 사용자 ID가 없습니다. 로그인 성공 후 ExerciseApi.setUserId(userId)를 '
        '호출하거나 테스트용 API_USER_ID를 설정해 주세요.',
      );
    }
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'x-user-id': id,
    };
  }

  /// [selectedDuration]의 0(전체)은 서버가 허용하는 최대 120분으로 전송합니다.
  /// 서버(reco/service.js)가 추천을 생성하고, 프론트는 서버가 선택한 운동만 표시합니다.
  static Future<List<ExerciseData>> recommend({
    required double cravingLevel,
    required int selectedDuration,
  }) async {
    try {
      final headers = _headers;
      final response = await http
          .post(
            Uri.parse('$_baseUrl/api/recommendations'),
            headers: headers,
            body: jsonEncode({
              'symptomType': 'CRAVING',
              'cravingLevel': cravingLevel.round().clamp(0, 10),
              'availableMinutes': selectedDuration == 0
                  ? 120
                  : selectedDuration,
              'location': 'ANY',
              'hasEquipment': false,
            }),
          )
          .timeout(const Duration(seconds: 30));

      _checkStatus(response, '운동 추천 요청');
      final responseBody = _parseJson(response.body);
      final recommendations = _extractRecommendations(responseBody);
      if (recommendations.isEmpty) return [];

      // 추천 API가 운동 ID만 반환할 수도 있으므로, 필요한 경우 DB 카탈로그에서
      // 운동 설명·진행 방법을 조회합니다. 추천되지 않은 운동은 표시하지 않습니다.
      final needsCatalog = recommendations.any((entry) {
        final row = _asMap(entry);
        final details = _exerciseObject(row);
        return _first(details, ['title', 'name']) == null ||
            _first(details, ['durationMinutes', 'duration_minutes']) == null ||
            _first(details, ['description']) == null ||
            _first(details, ['category', 'intensity']) == null ||
            _first(details, ['instructions', 'steps']) == null;
      });

      final Map<int, Map<String, dynamic>> catalog = needsCatalog
          ? await _fetchCatalog(headers)
          : <int, Map<String, dynamic>>{};

      return recommendations.map((entry) {
        final item = _asMap(entry);
        final exercise = _exerciseObject(item);
        final exerciseId = _asInt(
          _first(item, ['exerciseId', 'exercise_id']) ??
              _first(exercise, ['exerciseId', 'exercise_id', 'id']) ??
              (entry is num ? entry : null),
        );
        if (exerciseId == null || exerciseId <= 0) {
          throw const ExerciseApiException(
            '추천 결과에 exerciseId가 없습니다. reco/service.js 응답 형식을 확인해 주세요.',
          );
        }

        final fromDb = catalog[exerciseId] ?? <String, dynamic>{};
        // DB 기본 데이터 위에 추천 API가 반환한 데이터를 덮어씁니다.
        // 카멜/스네이크 표기 차이는 _first()가 흡수합니다.
        final merged = {...fromDb, ...exercise};
        final title = _asText(_first(merged, ['title', 'name']));
        final minutes = _asInt(
          _first(merged, ['durationMinutes', 'duration_minutes']),
        );
        if (title.isEmpty || minutes == null || minutes <= 0) {
          throw ExerciseApiException(
            'DB에 운동 #$exerciseId의 이름 또는 소요 시간이 없습니다.',
          );
        }

        final reason = _asText(
          _first(item, ['reason', 'recommendationReason', 'recommendation_reason', 'explanation']),
        );
        final instructions = _first(merged, ['instructions', 'steps']);
        final steps = _parseSteps(instructions);
        final category = _asText(_first(merged, ['category']));
        final intensity = _asText(_first(merged, ['intensity']));

        return ExerciseData(
          exerciseId: exerciseId,
          recommendationId: _asInt(
            _first(item, ['recommendationId', 'recommendation_id']),
          ),
          reason: reason.isEmpty ? null : reason,
          title: title,
          duration: '$minutes분',
          difficulty: _difficultyName(intensity),
          category: _categoryName(category),
          description: _asText(_first(merged, ['description'])),
          steps: steps,
          // DB에는 반복 횟수 전용 컬럼이 없습니다. 임의의 값을 만들지 않습니다.
          repeat: '',
        );
      }).toList(growable: false);
    } on TimeoutException {
      throw const ExerciseApiException('서버 응답 시간이 초과됐습니다. 백엔드 실행 상태를 확인해 주세요.');
    } on ExerciseApiException {
      rethrow;
    } on FormatException catch (e) {
      throw ExerciseApiException('서버 응답을 해석하지 못했습니다: ${e.message}');
    } catch (e) {
      throw ExerciseApiException(
        '서버에 연결할 수 없습니다. API_BASE_URL과 백엔드 실행 상태를 확인해 주세요. ($e)',
      );
    }
  }

  static Future<Map<int, Map<String, dynamic>>> _fetchCatalog(
    Map<String, String> headers,
  ) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/api/exercises'), headers: headers)
        .timeout(const Duration(seconds: 15));
    _checkStatus(response, '운동 정보 조회');
    final decoded = _parseJson(response.body);
    if (decoded is! List) {
      throw const ExerciseApiException('/api/exercises가 JSON 배열을 반환하지 않습니다.');
    }
    final catalog = <int, Map<String, dynamic>>{};
    for (final raw in decoded) {
      final exercise = _asMap(raw);
      final id = _asInt(_first(exercise, ['exercise_id', 'exerciseId']));
      if (id != null) catalog[id] = exercise;
    }
    return catalog;
  }

  static void _checkStatus(http.Response response, String name) {
    if (response.statusCode >= 200 && response.statusCode < 300) return;
    final body = _parseJsonSafe(response.body);
    final message = body is Map
        ? _asText(body['message'] ?? body['error'])
        : '';
    throw ExerciseApiException(
      '$name 실패 (HTTP ${response.statusCode})'
      '${message.isEmpty ? '' : ': $message'}',
    );
  }

  static dynamic _parseJson(String body) => jsonDecode(body);

  static dynamic _parseJsonSafe(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  // reco/service.js 코드가 아직 제공되지 않았으므로 흔히 쓰이는 응답 래퍼를
  // 처리합니다. 실제 결과 형식이 다르면 이 메서드만 맞춰 수정하면 됩니다.
  static List<dynamic> _extractRecommendations(dynamic value) {
    if (value is List) return value;
    if (value is Map) {
      final object = Map<String, dynamic>.from(value);
      for (final key in [
        'recommendations',
        'recommendedExercises',
        'recommended_exercises',
        'items',
        'results',
        'exercises',
        'suggestions',
        'ranked',
        'data',
        'result',
      ]) {
        if (object.containsKey(key)) {
          return _extractRecommendations(object[key]);
        }
      }
      for (final key in ['recommendation', 'recommendedExercise']) {
        if (object[key] != null) return [object[key]];
      }
      if (_first(object, ['exerciseId', 'exercise_id', 'exercise']) != null) {
        return [object];
      }
    }
    throw const ExerciseApiException(
      '추천 API 응답의 운동 목록 위치를 알 수 없습니다. '
      '백엔드 reco/service.js 반환 형식을 확인해 주세요.',
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is num || value is String) return {'exercise_id': value};
    throw const ExerciseApiException('추천 운동 항목이 올바른 JSON 객체가 아닙니다.');
  }

  static Map<String, dynamic> _exerciseObject(Map<String, dynamic> item) {
    final nested = item['exercise'];
    if (nested is Map) return {...item, ...Map<String, dynamic>.from(nested)};
    if (nested is num || nested is String) return {...item, 'exercise_id': nested};
    return item;
  }

  static dynamic _first(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      if (map.containsKey(key) && map[key] != null) return map[key];
    }
    return null;
  }

  static int? _asInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static String _asText(dynamic value) => value?.toString().trim() ?? '';

  static List<String> _parseSteps(dynamic instructions) {
    if (instructions is List) {
      return instructions.map(_asText).where((s) => s.isNotEmpty).toList();
    }
    final text = _asText(instructions);
    if (text.isEmpty) return [];
    return text
        .split(RegExp(r'\s*(?:→|->|\n)\s*'))
        .map((step) => step.trim())
        .where((step) => step.isNotEmpty)
        .toList();
  }

  static String _difficultyName(String name) {
    switch (name.toUpperCase()) {
      case 'LOW': return '낮음';
      case 'MEDIUM': return '보통';
      case 'HIGH': return '높음';
      default: return name;
    }
  }

  static String _categoryName(String name) {
    switch (name.toUpperCase()) {
      case 'BREATHING': return '호흡';
      case 'STRETCHING': return '스트레칭';
      case 'WALKING': return '걷기';
      case 'STRENGTH': return '근력';
      case 'CARDIO': return '유산소';
      case 'MINDFULNESS': return '명상';
      case 'YOGA': return '요가';
      default: return name;
    }
  }
}

class ExerciseApiException implements Exception {
  final String message;
  const ExerciseApiException(this.message);

  @override
  String toString() => message;
}
