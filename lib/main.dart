import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 테마 색상
  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color card = Color.fromRGBO(253, 253, 246, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
  static const Color litGreen = Color(0xFFEEF2DE);
  static const Color borderGreen =
  Color.fromRGBO(210, 220, 190, 1.0);
  static const Color textGray =
  Color.fromRGBO(95, 95, 85, 1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: cream,
        colorSchemeSeed: darkGreen,
        fontFamily: 'sans',
      ),

      home: Scaffold(
        backgroundColor: cream,

        // -------------------------
        // 상단
        // -------------------------
        appBar: AppBar(
          backgroundColor: cream,
          elevation: 0,

          toolbarHeight: 130,
          titleSpacing: 0,

          title: Stack(
            children: [
              Image.asset(
                'assets/SmokeOut_banner.png',
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
                          'Smoke Out',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: darkGreen,
                          ),
                        ),
                        const Icon(
                          Icons.eco,
                          color: green,
                          size: 22,
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '조금씩 더 건강한 나를 위해',
                      style: TextStyle(
                        fontSize: 12,
                        color: textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // -------------------------
        // 본문
        // -------------------------
        body: SingleChildScrollView(
          child: Column(
            children: [

              // ==================================================
              // 금연 현황
              // ==================================================
              Container(
                height: 120,
                margin: const EdgeInsets.fromLTRB(6, 3, 6, 6),
                padding: const EdgeInsets.only(top: 4),

                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderGreen,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  children: [

                    // 제목 + 상세보기
                    Row(
                      children: [
                        const SizedBox(width: 5),

                        const Icon(
                          Icons.leaderboard_outlined,
                          color: darkGreen,
                          size: 21,
                        ),

                        const SizedBox(width: 2),

                        const Text(
                          '금연 현황',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: darkGreen,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Row(
                            children: [
                              Text(
                                '상세보기',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: darkGreen,
                                ),
                              ),

                              Icon(
                                Icons.chevron_right,
                                size: 17,
                                color: darkGreen,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // 금연 현황 3개
                    SizedBox(
                      height: 65,
                      child: Row(
                        children: [

                          // 금연한 일
                          Expanded(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),

                                const Icon(
                                  Icons.calendar_month,
                                  color: darkGreen,
                                  size: 22,
                                ),

                                const SizedBox(width: 5),

                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '금연한 일',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textGray,
                                      ),
                                    ),

                                    Text(
                                      '15일',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: darkGreen,
                                      ),
                                    ),

                                    Text(
                                      '(2025.09.13)',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 구분선
                          Container(
                            width: 1,
                            height: 60,
                            color: borderGreen,
                          ),

                          // 참은 담배
                          Expanded(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),

                                Image.asset(
                                  'assets/smoke_free.png',
                                  width: 24,
                                  height: 24,
                                ),

                                const SizedBox(width: 5),

                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '참은 담배',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textGray,
                                      ),
                                    ),

                                    Text(
                                      '300개비',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: darkGreen,
                                      ),
                                    ),

                                    Text(
                                      '(2025.09.13)',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 구분선
                          Container(
                            width: 1,
                            height: 60,
                            color: borderGreen,
                          ),

                          // 아낀 금액
                          Expanded(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),

                                const Icon(
                                  Icons.payment,
                                  color: darkGreen,
                                  size: 22,
                                ),

                                const SizedBox(width: 5),

                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '아낀 금액',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textGray,
                                      ),
                                    ),

                                    Text(
                                      '120,000원',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: darkGreen,
                                      ),
                                    ),

                                    Text(
                                      '(1갑 4000원 기준)',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // 랭킹 + 금연하기
              // ==================================================
              Row(
                children: [

                  // 랭킹
                  Expanded(
                    child: Container(
                      height: 110,
                      margin: const EdgeInsets.fromLTRB(6, 3, 3, 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),

                      decoration: BoxDecoration(
                        color: litGreen,
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                          color: borderGreen,
                          width: 1.5,
                        ),
                      ),

                      child: Row(
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            size: 43,
                            color: darkGreen,
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '랭킹',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: darkGreen,
                                  ),
                                ),

                                Text(
                                  '현재 나의 순위',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: textGray,
                                  ),
                                ),

                                Text(
                                  '1위',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: darkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            size: 28,
                            color: darkGreen,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 금연하기
                  Expanded(
                    child: Container(
                      height: 110,
                      margin: const EdgeInsets.fromLTRB(3, 3, 6, 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),

                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(17),
                      ),

                      child: Row(
                        children: [
                          Image.asset(
                            'assets/smoke_free.png',
                            width: 48,
                            height: 48,
                          ),

                          const SizedBox(width: 5),

                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '금연하기',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: cream,
                                  ),
                                ),

                                Text(
                                  '오늘도 금연 성공해요!',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: cream,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            color: cream,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ==================================================
              // 운동 현황
              // ==================================================
              Container(
                height: 165,
                margin: const EdgeInsets.fromLTRB(6, 3, 6, 5),
                padding: const EdgeInsets.fromLTRB(7, 5, 7, 8),

                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderGreen,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  children: [

                    // 제목
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_run,
                          color: darkGreen,
                          size: 20,
                        ),

                        const SizedBox(width: 3),

                        const Text(
                          '운동 현황',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: darkGreen,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text(
                            '오늘도 화이팅!',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // 운동 정보
                    Expanded(
                      child: Row(
                        children: [

                          // 걸음 수
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                color: litGreen,
                                borderRadius:
                                BorderRadius.circular(15),
                              ),

                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.directions_walk,
                                    size: 38,
                                    color: darkGreen,
                                  ),

                                  SizedBox(width: 7),

                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '오늘의 걸음 수',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textGray,
                                        ),
                                      ),

                                      SizedBox(height: 3),

                                      Text(
                                        '8,431 걸음',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: darkGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // 소모 칼로리
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                color: litGreen,
                                borderRadius:
                                BorderRadius.circular(15),
                              ),

                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.local_fire_department,
                                    size: 34,
                                    color: darkGreen,
                                  ),

                                  SizedBox(width: 7),

                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '오늘의 소모 칼로리',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textGray,
                                        ),
                                      ),

                                      SizedBox(height: 3),

                                      Text(
                                        '125,345 kcal',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: darkGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // ==================================================
              // 금연의 이로움
              // ==================================================
              Container(
                margin: const EdgeInsets.fromLTRB(6, 3, 6, 10),
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    239,
                    246,
                    220,
                    1.0,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderGreen,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    // 제목
                    Row(
                      children: const [
                        Icon(
                          Icons.eco,
                          color: darkGreen,
                          size: 23,
                        ),

                        SizedBox(width: 4),

                        Text(
                          '금연의 이로움',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      '금연을 시작한 순간부터 몸은 회복되기 시작해요.',
                      style: TextStyle(
                        fontSize: 10,
                        color: textGray,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _BenefitItem(
                      time: '20분',
                      text:
                      '혈압과 심장박동이 정상으로 돌아오고 손발 체온이 상승합니다.',
                    ),

                    _BenefitItem(
                      time: '12시간',
                      text:
                      '혈중 산소량이 정상으로 올라가고 일산화탄소 수치가 정상화됩니다.',
                    ),

                    _BenefitItem(
                      time: '2주~3개월',
                      text:
                      '혈액순환이 원활해지고 폐 기능이 향상됩니다.',
                    ),

                    _BenefitItem(
                      time: '1년',
                      text:
                      '심장마비 및 심장병 발생 위험이 감소합니다.',
                    ),

                    _BenefitItem(
                      time: '10년',
                      text:
                      '폐암 및 각종 암 위험이 크게 낮아집니다.',
                    ),

                    _BenefitItem(
                      time: '15년',
                      text:
                      '심혈관질환 위험이 비흡연자 수준으로 낮아집니다.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ==================================================
        // 하단 네비게이션
        // ==================================================
        bottomNavigationBar: BottomAppBar(
          height: 68,
          color: cream,
          elevation: 0,

          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: const [

              _BottomItem(
                icon: Icons.home,
                label: '홈',
                selected: true,
              ),

              _BottomItem(
                icon: Icons.directions_run,
                label: '운동',
              ),

              _BottomItem(
                icon: Icons.emoji_events_outlined,
                label: '랭킹',
              ),

              _BottomItem(
                icon: Icons.smoke_free,
                label: '금연',
              ),

              _BottomItem(
                icon: Icons.person_outline,
                label: 'MY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ==========================================================
// 금연의 이로움 한 줄
// ==========================================================
class _BenefitItem extends StatelessWidget {
  final String time;
  final String text;

  const _BenefitItem({
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // 시간
          Container(
            width: 65,
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 5,
            ),

            decoration: BoxDecoration(
              color: MyApp.green,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Text(
              time,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: MyApp.cream,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 설명
          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 10,
                height: 1.3,
                color: MyApp.textGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ==========================================================
// 하단 네비게이션 아이템
// ==========================================================
class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _BottomItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,

      children: [
        Icon(
          icon,
          size: 23,
          color: selected
              ? MyApp.darkGreen
              : Colors.black45,
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: selected
                ? MyApp.darkGreen
                : Colors.black45,
            fontWeight: selected
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}