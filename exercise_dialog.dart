
import 'package:flutter/material.dart';
import 'exercise_detail.dart';

// 추천 운동 5가지
const recommendedExercises = <ExerciseData>[
  ExerciseData(
    title: '박스 호흡',
    duration: '3분',
    difficulty: '낮음',
    category: '호흡',
    description: '같은 길이로 들이쉬고 멈추고 내쉬며 흥분 상태를 진정시킵니다.',
    steps: [
      '4초 들이마시기',
      '4초 멈추기',
      '4초 내쉬기',
      '4초 멈추기',
    ],
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 410,
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'AI 맞춤 운동 추천',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                '현재 욕구와 조건에 맞는 운동 5가지를 추천해드려요.',
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // 운동 목록
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final exercise in recommendedExercises)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: exerciseItem(context, exercise),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 42,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 운동 항목
  Widget exerciseItem(BuildContext context, ExerciseData exercise) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailScreen(
              exercise: exercise,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${exercise.duration} · ${exercise.difficulty} · ${exercise.category}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
