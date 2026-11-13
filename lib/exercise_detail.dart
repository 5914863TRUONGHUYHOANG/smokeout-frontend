import 'package:flutter/material.dart';

// exercise_dialog.dart의 추천 운동 목록에서도 이 모델을 사용합니다.
class ExerciseData {
  // 서버에서 받은 식별자. 프론트에서 임의의 운동을 생성하지 않습니다.
  final int exerciseId;
  final int? recommendationId;
  final String? reason;
  final String title;
  final String duration;
  final String difficulty;
  final String category;
  final String description;
  final List<String> steps;
  final String repeat;

  const ExerciseData({
    required this.exerciseId,
    this.recommendationId,
    this.reason,
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.category,
    required this.description,
    required this.steps,
    required this.repeat,
  });
}

// 운동 추천 팝업에서 운동을 눌렀을 때 열리는 상세 Dialog입니다.
class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseData exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  static const Color _cream = Color(0xFFFDFDF6);
  static const Color _darkGreen = Color(0xFF3F5C2B);
  static const Color _green = Color(0xFF5B7E3D);
  static const Color _softGreen = Color(0xFFEEF2DE);
  static const Color _borderGreen = Color(0xFFD2DCBE);
  static const Color _secondaryText = Color(0xFF6E7565);

  IconData get _categoryIcon {
    switch (exercise.category) {
      case '호흡':
        return Icons.air_rounded;
      case '스트레칭':
        return Icons.accessibility_new_rounded;
      case '걷기':
        return Icons.directions_walk_rounded;
      case '근력':
        return Icons.fitness_center_rounded;
      case '명상':
        return Icons.self_improvement_rounded;
      case '유산소':
        return Icons.favorite_outline_rounded;
      case '요가':
        return Icons.self_improvement_rounded;
      default:
        return Icons.spa_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _cream,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: _borderGreen, width: 1.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 440,
          maxHeight: MediaQuery.sizeOf(context).height * 0.84,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더: 추천 목록으로 돌아갈 수 있고, 상세 팝업만 닫힙니다.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
              child: Row(
                children: [
                  const Icon(Icons.eco_rounded, color: _green, size: 21),
                  const SizedBox(width: 7),
                  const Expanded(
                    child: Text(
                      '운동 상세 가이드',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _darkGreen,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: '운동 상세 닫기',
                    icon: const Icon(Icons.close_rounded, color: _secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 상세 내용만 스크롤됩니다. 아래 버튼은 고정됩니다.
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _hero(),
                    const SizedBox(height: 18),
                    _sectionTitle(Icons.info_outline_rounded, '운동 설명'),
                    const SizedBox(height: 9),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: _cardDecoration(),
                      child: Text(
                        exercise.description.isEmpty
                            ? 'DB에 운동 설명이 등록되지 않았습니다.'
                            : exercise.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: Color(0xFF394335),
                        ),
                      ),
                    ),
                    if (exercise.reason != null && exercise.reason!.trim().isNotEmpty) ...[
                      const SizedBox(height: 18),
                      _sectionTitle(Icons.auto_awesome_outlined, '추천 이유'),
                      const SizedBox(height: 9),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: _cardDecoration(),
                        child: Text(
                          exercise.reason!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.55,
                            color: Color(0xFF394335),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    _sectionTitle(Icons.format_list_numbered_rounded, '진행 방법'),
                    const SizedBox(height: 9),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 12),
                      decoration: _cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (exercise.steps.isEmpty)
                            const Text(
                              'DB에 등록된 진행 방법이 없습니다.',
                              style: TextStyle(color: _secondaryText),
                            ),
                          for (int i = 0; i < exercise.steps.length; i++) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: _softGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: _darkGreen,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      exercise.steps[i],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.45,
                                        color: Color(0xFF394335),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (i != exercise.steps.length - 1)
                              const SizedBox(height: 13),
                          ],
                          if (exercise.repeat.trim().isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(color: _borderGreen, height: 1),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer_outlined, color: _green, size: 20),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    exercise.repeat,
                                    style: const TextStyle(
                                      color: _darkGreen,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),

            // 추천 팝업에 돌아가기 / 완료하기
            Container(
              padding: const EdgeInsets.fromLTRB(18, 13, 18, 17),
              decoration: const BoxDecoration(
                color: _cream,
                border: Border(top: BorderSide(color: _borderGreen)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _darkGreen,
                        side: const BorderSide(color: _borderGreen),
                        minimumSize: const Size(0, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        '뒤로가기',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 46),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () => _showCompletion(context),
                      child: const Text(
                        '운동 완료',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0F5E1), Color(0xFFE3EED0)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: _cream,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(_categoryIcon, color: _green, size: 31),
              ),
              const Spacer(),
              const Icon(Icons.spa_rounded, color: Color(0xFFBDD0A3), size: 40),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            exercise.title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: _darkGreen,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              _chip(Icons.schedule_rounded, exercise.duration),
              _chip(Icons.signal_cellular_alt_rounded, exercise.difficulty),
              _chip(_categoryIcon, exercise.category),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _green, size: 14),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: _darkGreen,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: _green, size: 19),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            color: _darkGreen,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: _borderGreen),
    );
  }

  Future<void> _showCompletion(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: _green),
            SizedBox(width: 8),
            Text('운동 완료!'),
          ],
        ),
        content: Text('${exercise.title} 운동을 완료했어요!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // 완료 알림 닫기
              Navigator.pop(context); // 상세 팝업만 닫고 추천 목록으로 돌아가기
            },
            child: const Text('확인', style: TextStyle(color: _darkGreen)),
          ),
        ],
      ),
    );
  }
}
