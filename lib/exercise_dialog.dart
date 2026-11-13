import 'package:flutter/material.dart';

import 'exercise_detail.dart';

// 기존 앱의 크림색·초록색 테마와 일치하도록 유지했습니다.
const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
const Color card = Color.fromRGBO(253, 253, 246, 1.0);
const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
const Color green = Color.fromRGBO(91, 126, 61, 1.0);
const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
const Color litGreen = Color(0xFFEEF2DE);
const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);
const Color textGray = Color.fromRGBO(95, 95, 85, 1.0);

class ExerciseRecommendDialog extends StatefulWidget {
  final double cravingLevel;
  final int selectedDuration;
  // exercise.dart에서 API 호출 함수를 전달받습니다.
  final Future<List<ExerciseData>> Function() loadRecommendations;

  const ExerciseRecommendDialog({
    super.key,
    required this.cravingLevel,
    required this.selectedDuration,
    required this.loadRecommendations,
  });

  @override
  State<ExerciseRecommendDialog> createState() =>
      _ExerciseRecommendDialogState();
}

class _ExerciseRecommendDialogState extends State<ExerciseRecommendDialog> {
  late Future<List<ExerciseData>> _recommendations;

  @override
  void initState() {
    super.initState();
    _requestRecommendations();
  }

  void _requestRecommendations() {
    _recommendations = widget.loadRecommendations();
  }

  void _retry() {
    setState(_requestRecommendations);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: cream,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: borderGreen),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 440,
          maxHeight: MediaQuery.sizeOf(context).height * 0.86,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 헤더: 기존 추천 제목은 유지하고 더 명확한 정보 구조로 정리.
              Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: lightGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.spa_outlined,
                  color: darkGreen,
                  size: 29,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'AI 맞춤 운동 추천',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                '서버에서 선택한 맞춤 운동을 보여드려요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: textGray, height: 1.45),
              ),
              const SizedBox(height: 11),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: [
                  _conditionTag('욕구 강도 ${widget.cravingLevel.toInt()}/10'),
                  _conditionTag(widget.selectedDuration == 0
                      ? '시간 전체'
                      : '${widget.selectedDuration}분 이내'),
                ],
              ),
              const SizedBox(height: 17),
              // DB에 등록된 운동 중 서버가 추천한 목록만 사용합니다.
              // 요청 중/오류/결과 없음의 상태를 각각 구분합니다.
              Flexible(
                child: FutureBuilder<List<ExerciseData>>(
                  future: _recommendations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: green),
                            SizedBox(height: 14),
                            Text('맞춤 운동을 불러오는 중...',
                                style: TextStyle(color: textGray)),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return _messageView(
                        icon: Icons.wifi_off_rounded,
                        message: snapshot.error.toString(),
                        showRetry: true,
                      );
                    }
                    final exercises = snapshot.data ?? const <ExerciseData>[];
                    if (exercises.isEmpty) {
                      return _messageView(
                        icon: Icons.search_off_rounded,
                        message: '현재 조건에 맞는 추천 운동이 없습니다.\n'
                            '시간을 늘려 다시 시도해 주세요.',
                        showRetry: true,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 2),
                      itemCount: exercises.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 9),
                      itemBuilder: (context, index) =>
                          exerciseItem(context, exercises[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: darkGreen,
                    backgroundColor: card,
                    side: const BorderSide(color: borderGreen, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _conditionTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: litGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderGreen),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _messageView({
    required IconData icon,
    required String message,
    required bool showRetry,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: textGray),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: textGray)),
            if (showRetry) ...[
              const SizedBox(height: 14),
              OutlinedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: const Text('다시 시도'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String category) {
    switch (category) {
      case '호흡':
        return Icons.air;
      case '스트레칭':
        return Icons.accessibility_new_rounded;
      case '걷기':
        return Icons.directions_walk_rounded;
      case '근력':
        return Icons.fitness_center_rounded;
      case '명상':
        return Icons.self_improvement_rounded;
      case '요가':
        return Icons.self_improvement_rounded;
      case '유산소':
        return Icons.favorite_outline_rounded;
      default:
        return Icons.spa_rounded;
    }
  }

  // 서버 추천 항목을 누르면 기존 운동 상세 Dialog를 엽니다.
  Widget exerciseItem(BuildContext context, ExerciseData exercise) {
    return Material(
      color: card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) =>
                ExerciseDetailScreen(exercise: exercise),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: borderGreen, width: 1.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: litGreen,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  _iconFor(exercise.category),
                  color: green,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${exercise.duration}  ·  ${exercise.difficulty}  ·  ${exercise.category}',
                      style: const TextStyle(color: textGray, fontSize: 12),
                    ),
                    if (exercise.reason?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 5),
                      Text(
                        exercise.reason!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: textGray, fontSize: 11),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: green, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
