import 'package:flutter/material.dart';
import 'exercise_dialog.dart';
import 'profile_screen.dart';


class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  // 테마 색상
  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color card = Color.fromRGBO(253, 253, 246, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
  static const Color litGreen = Color(0xFFEEF2DE);
  static const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);
  static const Color textGray = Color.fromRGBO(95, 95, 85, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 상단 제목
              Container(
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('지금 나에게 맞는 운동을 찾아보세요'),

                    //욕구 강도
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Row(children: [Text('욕구강도'), Text('(0~10)')]),

                            Spacer(),

                            Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('7', style: TextStyle(fontSize: 16)),
                                    Text(' / ', style: TextStyle(fontSize: 12)),
                                    Text('10', style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),

                        Slider(
                          min: 0,
                          value: 7, // 현재 위치
                          max: 10,
                          divisions: 10, // 1씩 움직이기
                          onChanged: (_) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
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

                    // 현재 체력상태
                    // 일단은 삭제

                    // 운동시간
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('운동시간'),
                        SizedBox(width: 12),
                        Expanded(
                          child: SegmentedButton(
                            segments: [
                              ButtonSegment(value: 0, label: Text('전체')),
                              ButtonSegment(value: 5, label: Text('5분')),
                              ButtonSegment(value: 10, label: Text('10분')),
                              ButtonSegment(value: 15, label: Text('15분')),
                              ButtonSegment(value: 30, label: Text('30분')),
                            ],
                            selected: {0},
                            onSelectionChanged: (newSelection) {},
                            showSelectedIcon: false,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // 운동 추천 버튼
                    Align(
                      alignment: Alignment.center,
                      child:GestureDetector(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            child: Text(
                              '맞춤 운동 추천받기',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              // 여기에 운동 화면 레이아웃 추가
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: const Color(0xFFF8F7F0),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomItem(
              icon: Icons.home,
              label: '홈',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _BottomItem(
              icon: Icons.directions_run,
              label: '운동',
              selected: true,
            ),
            _BottomItem(icon: Icons.emoji_events_outlined, label: '랭킹'),
            _BottomItem(
              icon: Icons.person_outline,
              label: 'MY',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: selected ? Colors.black : Colors.grey),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.black : Colors.grey,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
