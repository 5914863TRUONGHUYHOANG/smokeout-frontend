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

// 운동 내용과 상세 화면으로 넘어가는 기능은 변경하지 않았습니다.
const recommendedExercises = <ExerciseData>[
  ExerciseData(
    title: '박스 호흡',
    duration: '3분',
    difficulty: '낮음',
    category: '호흡',
    description: '같은 길이로 들이쉬고 멈추고 내쉬며 흥분 상태를 진정시킵니다.',
    steps: ['4초 들이마시기', '4초 멈추기', '4초 내쉬기', '4초 멈추기'],
    repeat: '총 6회 반복',
  ),
  ExerciseData(
    title: '목·어깨 스트레칭',
    duration: '5분',
    difficulty: '낮음',
    category: '스트레칭',
    description: '목과 어깨의 긴장을 풀고 몸을 편안하게 만들어줍니다.',
    steps: [
      '고개를 오른쪽으로 천천히 기울이기',
      '15초 유지 후 반대쪽도 반복하기',
      '어깨를 천천히 앞뒤로 돌리기',
      '무리하지 않고 동작 반복하기',
    ],
    repeat: '약 5분 진행',
  ),
  ExerciseData(
    title: '가벼운 걷기 10분',
    duration: '10분',
    difficulty: '낮음',
    category: '걷기',
    description: '가볍게 걸으며 흡연 욕구에서 주의를 돌리고 기분을 전환합니다.',
    steps: [
      '편안한 자세로 걷기 시작하기',
      '자연스럽게 호흡하기',
      '주변 풍경과 발걸음에 집중하기',
      '일정한 속도로 걷기 유지하기',
    ],
    repeat: '총 10분 진행',
  ),
  ExerciseData(
    title: '벽 밀기·플랭크 코어',
    duration: '6분',
    difficulty: '보통',
    category: '근력',
    description: '벽을 이용한 근력 운동으로 몸을 움직이며 긴장을 해소합니다.',
    steps: [
      '벽 앞에 서서 양손을 벽에 대기',
      '팔꿈치를 천천히 굽혔다 펴기',
      '벽을 짚고 플랭크 자세 유지하기',
      '휴식하며 동작 반복하기',
    ],
    repeat: '약 6분 진행',
  ),
  ExerciseData(
    title: '욕구 서핑 명상',
    duration: '5분',
    difficulty: '낮음',
    category: '명상',
    description: '흡연 욕구를 억지로 없애려 하지 않고 자연스럽게 지나가도록 관찰합니다.',
    steps: [
      '편안한 자세로 앉기',
      '현재 느껴지는 흡연 욕구 알아차리기',
      '호흡과 몸의 감각에 집중하기',
      '욕구의 변화를 차분히 관찰하기',
    ],
    repeat: '총 5분 진행',
  ),
];

class ExerciseRecommendDialog extends StatelessWidget {
  const ExerciseRecommendDialog({super.key});

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
                child: const Icon(Icons.spa_outlined, color: darkGreen, size: 29),
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
                '현재 욕구와 조건에 맞는 운동 5가지를 추천해드려요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: textGray, height: 1.45),
              ),
              const SizedBox(height: 17),

              const SizedBox(height: 10),
              // 모바일 화면에서는 카드 목록만 스크롤됩니다.
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 2),
                  itemCount: recommendedExercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 9),
                  itemBuilder: (context, index) {
                    return exerciseItem(context, recommendedExercises[index]);
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
      default:
        return Icons.spa_rounded;
    }
  }

  // 디자인만 변경: 항목을 누르면 예전과 동일하게 운동 상세 Dialog로 이동합니다.
  Widget exerciseItem(BuildContext context, ExerciseData exercise) {
    return Material(
      color: card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) => ExerciseDetailScreen(exercise: exercise),
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
                child: Icon(_iconFor(exercise.category), color: green, size: 26),
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
