import 'package:flutter/material.dart';

import 'exercise_dialog.dart';

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
                                          setState(() {
                                            selectedDuration =
                                                newSelection.first;
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ExerciseRecommendDialog();
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
