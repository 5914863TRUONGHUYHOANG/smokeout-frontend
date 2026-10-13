import 'package:flutter/material.dart';
import '../models/recommendation_model.dart';
import '../services/api_service.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // AI Recommendation form state
  String _symptomType = 'CRAVING';
  double _cravingLevel = 7;
  int _availableMinutes = 10;
  String _location = 'INDOOR';
  bool _isLoadingReco = false;
  RecommendationResult? _recommendationResult;

  // Catalog state
  late Future<List<Exercise>> _exercisesFuture;

  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color card = Color.fromRGBO(253, 253, 246, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
  static const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _exercisesFuture = ApiService.instance.getExercises();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _requestRecommendation() async {
    if (!ApiService.instance.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AI 추천을 받으려면 먼저 로그인해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoadingReco = true;
    });

    try {
      final res = await ApiService.instance.getRecommendations(
        symptomType: _symptomType,
        cravingLevel: _cravingLevel.toInt(),
        availableMinutes: _availableMinutes,
        location: _location,
      );
      setState(() {
        _recommendationResult = res;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('추천 요청 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingReco = false;
        });
      }
    }
  }

  Future<void> _completeExercise(Exercise exercise, int? recoId, int? symId) async {
    try {
      await ApiService.instance.logExercise(
        exerciseId: exercise.exerciseId,
        durationCompleted: exercise.durationMinutes > 0 ? exercise.durationMinutes : 5,
        recommendationId: recoId,
        symptomLogId: symId,
        intensityAfter: 2,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: darkGreen,
            content: Text('🎉 운동 완료 기록! 포인트가 지급되었습니다.'),
          ),
        );
        setState(() {
          _recommendationResult = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('기록 실패: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        title: const Text(
          '운동 & AI 맞춤 추천',
          style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: darkGreen,
          unselectedLabelColor: Colors.grey,
          indicatorColor: darkGreen,
          tabs: const [
            Tab(text: 'AI 맞춤 추천'),
            Tab(text: '운동 카탈로그'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: AI Recommendation
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Thẻ cài đặt triệu chứng
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderGreen, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '지금 흡연 욕구가 드시나요?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 증상 선택
                      const Text('현재 상태 / 증상:', style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('흡연 욕구 (CRAVING)'),
                            selected: _symptomType == 'CRAVING',
                            selectedColor: lightGreen,
                            onSelected: (_) => setState(() => _symptomType = 'CRAVING'),
                          ),
                          ChoiceChip(
                            label: const Text('스트레스 (STRESS)'),
                            selected: _symptomType == 'STRESS',
                            selectedColor: lightGreen,
                            onSelected: (_) => setState(() => _symptomType = 'STRESS'),
                          ),
                          ChoiceChip(
                            label: const Text('불안 / 초조 (ANXIETY)'),
                            selected: _symptomType == 'ANXIETY',
                            selectedColor: lightGreen,
                            onSelected: (_) => setState(() => _symptomType = 'ANXIETY'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 욕구 강도 (1~10)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('욕구 강도:', style: TextStyle(fontSize: 13)),
                          Text(
                            '${_cravingLevel.toInt()} / 10',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: darkGreen),
                          ),
                        ],
                      ),
                      Slider(
                        value: _cravingLevel,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: darkGreen,
                        onChanged: (val) => setState(() => _cravingLevel = val),
                      ),

                      // 가능 시간 & 장소
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _availableMinutes,
                              decoration: InputDecoration(
                                labelText: '운동 가능 시간',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                              items: const [
                                DropdownMenuItem(value: 5, child: Text('5분 (초단기)')),
                                DropdownMenuItem(value: 10, child: Text('10분')),
                                DropdownMenuItem(value: 15, child: Text('15분')),
                                DropdownMenuItem(value: 30, child: Text('30분')),
                              ],
                              onChanged: (val) => setState(() => _availableMinutes = val ?? 10),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _location,
                              decoration: InputDecoration(
                                labelText: '운동 장소',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'INDOOR', child: Text('실내 (INDOOR)')),
                                DropdownMenuItem(value: 'OUTDOOR', child: Text('야외 (OUTDOOR)')),
                                DropdownMenuItem(value: 'ANY', child: Text('무관 (ANY)')),
                              ],
                              onChanged: (val) => setState(() => _location = val ?? 'INDOOR'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      ElevatedButton.icon(
                        onPressed: _isLoadingReco ? null : _requestRecommendation,
                        icon: const Icon(Icons.auto_awesome, color: cream),
                        label: _isLoadingReco
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: cream, strokeWidth: 2),
                              )
                            : const Text('AI 맞춤 운동 추천받기', style: TextStyle(color: cream, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Kết quả gợi ý AI
                if (_recommendationResult != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: lightGreen.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: green, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.stars, color: darkGreen, size: 28),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _recommendationResult!.exercise.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: darkGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${_recommendationResult!.exercise.durationMinutes}분',
                                style: const TextStyle(color: cream, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '💡 AI 추천 사유: ${_recommendationResult!.reason}',
                          style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: darkGreen),
                        ),
                        const Divider(height: 20),
                        Text(
                          _recommendationResult!.exercise.description,
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('📌 운동 방법:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(_recommendationResult!.exercise.instructions, style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed: () => _completeExercise(
                            _recommendationResult!.exercise,
                            _recommendationResult!.recommendationId,
                            _recommendationResult!.symptomLogId,
                          ),
                          icon: const Icon(Icons.check_circle_outline, color: cream),
                          label: const Text('운동 완료하고 포인트 받기', style: TextStyle(color: cream, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green,
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // TAB 2: Exercises Catalog
          FutureBuilder<List<Exercise>>(
            future: _exercisesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: darkGreen));
              }
              if (snapshot.hasError) {
                return Center(child: Text('오류: ${snapshot.error}'));
              }
              final list = snapshot.data ?? [];
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ex = list[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderGreen),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ex.category,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: darkGreen),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ex.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen),
                              ),
                            ),
                            Text('${ex.durationMinutes}분', style: const TextStyle(color: green, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(ex.description, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                        const SizedBox(height: 6),
                        Text('방법: ${ex.instructions}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

