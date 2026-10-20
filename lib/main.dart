import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'services/api_service.dart';
import 'screens/auth_screen.dart';
import 'screens/exercise_screen.dart';
import 'screens/ranking_screen.dart';
// import 'screens/coach_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.instance.init();
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
  static const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);
  static const Color textGray = Color.fromRGBO(95, 95, 85, 1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Out',
      theme: ThemeData(
        scaffoldBackgroundColor: cream,
        colorSchemeSeed: darkGreen,
        fontFamily: 'sans',
      ),
      home: const MainTabController(),
    );
  }
}

class MainTabController extends StatefulWidget {
  const MainTabController({super.key});

  @override
  State<MainTabController> createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _currentIndex = 0;

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigateTab: _switchTab),
      const ExerciseScreen(),
      const RankingScreen(),
      // const CoachScreen(), // Tạm ẩn tính năng AI 코치
      const ProfileScreen(),
    ];

    final activeIndex = _currentIndex >= screens.length ? 0 : _currentIndex;

    return Scaffold(
      backgroundColor: MyApp.cream,
      body: screens[activeIndex],
      bottomNavigationBar: BottomAppBar(
        height: 68,
        padding: EdgeInsets.zero,
        color: MyApp.cream,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomItem(
              icon: Icons.home,
              label: '홈',
              selected: activeIndex == 0,
              onTap: () => _switchTab(0),
            ),
            _BottomItem(
              icon: Icons.directions_run,
              label: '운동',
              selected: activeIndex == 1,
              onTap: () => _switchTab(1),
            ),
            _BottomItem(
              icon: Icons.emoji_events_outlined,
              label: '랭킹',
              selected: activeIndex == 2,
              onTap: () => _switchTab(2),
            ),
            // Tạm ẩn AI 코치
            // _BottomItem(
            //   icon: Icons.chat_outlined,
            //   label: 'AI 코치',
            //   selected: activeIndex == 3,
            //   onTap: () => _switchTab(3),
            // ),
            _BottomItem(
              icon: Icons.person_outline,
              label: 'MY',
              selected: activeIndex == 3,
              onTap: () => _switchTab(3),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigateTab;

  const HomeScreen({super.key, required this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###');

    return ValueListenableBuilder(
      valueListenable: ApiService.instance.userNotifier,
      builder: (context, user, _) {
        // Tính toán thời gian bỏ thuốc & tiền tiết kiệm
        final now = DateTime.now();
        final startDate = user?.quitStartDate ?? now.subtract(const Duration(days: 30));
        final diff = now.difference(startDate);
        final smokeFreeDays = diff.inDays > 0 ? diff.inDays : 1;
        final smokeFreeHours = diff.inHours % 24;

        final dailyCount = user?.dailyCigaretteCount ?? 10;
        final packPrice = user?.packPrice ?? 4500;
        final totalSavedCigarettes = smokeFreeDays * dailyCount;
        final totalSavedMoney = ((totalSavedCigarettes / 20) * packPrice).toInt();

        return Scaffold(
          backgroundColor: MyApp.cream,
          // -------------------------
          // 상단 AppBar
          // -------------------------
          appBar: AppBar(
            backgroundColor: MyApp.cream,
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
                  errorBuilder: (_, _, _) => Container(
                    height: 130,
                    color: MyApp.lightGreen,
                  ),
                ),
                Positioned(
                  left: 25,
                  top: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: const [
                          Text(
                            'Smoke Out',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: MyApp.darkGreen,
                            ),
                          ),
                          Icon(
                            Icons.eco,
                            color: MyApp.green,
                            size: 22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user != null
                            ? '${user.nickname}님의 건강한 하루를 응원합니다!'
                            : '조금씩 더 건강한 나를 위해',
                        style: const TextStyle(
                          fontSize: 12,
                          color: MyApp.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 36,
                  child: user == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AuthScreen()),
                            );
                          },
                          icon: const Icon(Icons.login, size: 16, color: MyApp.cream),
                          label: const Text('로그인', style: TextStyle(color: MyApp.cream, fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyApp.darkGreen,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => onNavigateTab(3), // Chuyển sang tab MY
                          child: Chip(
                            backgroundColor: MyApp.lightGreen,
                            avatar: const Icon(Icons.person, color: MyApp.darkGreen, size: 16),
                            label: Text(
                              user.nickname,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: MyApp.darkGreen,
                              ),
                            ),
                          ),
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
                // 금연 현황 (Live Data)
                // ==================================================
                Container(
                  height: 120,
                  margin: const EdgeInsets.fromLTRB(6, 3, 6, 6),
                  padding: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: MyApp.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: MyApp.borderGreen,
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
                            color: MyApp.darkGreen,
                            size: 21,
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            '금연 현황',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyApp.darkGreen,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => onNavigateTab(3),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: MyApp.lightGreen,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                '상세보기',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: MyApp.darkGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Expanded(
                        child: Row(
                          children: [
                            // 금연 시간
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.access_time,
                                    color: MyApp.darkGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '금연 시간',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MyApp.textGray,
                                        ),
                                      ),
                                      Text(
                                        '$smokeFreeDays일 $smokeFreeHours시간',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.darkGreen,
                                        ),
                                      ),
                                      Text(
                                        '(${startDate.year}.${startDate.month}.${startDate.day} ~)',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: MyApp.textGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 참은 개비 수
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.smoke_free,
                                    color: MyApp.darkGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '참은 개비 수',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MyApp.textGray,
                                        ),
                                      ),
                                      Text(
                                        '${currencyFormatter.format(totalSavedCigarettes)}개비',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.darkGreen,
                                        ),
                                      ),
                                      Text(
                                        '(하루 $dailyCount개비 기준)',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: MyApp.textGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 아낀 금액
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.payment,
                                    color: MyApp.darkGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '아낀 금액',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MyApp.textGray,
                                        ),
                                      ),
                                      Text(
                                        '${currencyFormatter.format(totalSavedMoney)}원',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.darkGreen,
                                        ),
                                      ),
                                      Text(
                                        '(1갑 $packPrice원 기준)',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: MyApp.textGray,
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
                // 랭킹 + 금연하기 (Chuyển trang trực tiếp)
                // ==================================================
                Row(
                  children: [
                    // 랭킹 카드
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onNavigateTab(2), // Đến trang 랭킹
                        child: Container(
                          height: 110,
                          margin: const EdgeInsets.fromLTRB(6, 3, 3, 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: MyApp.litGreen,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: MyApp.borderGreen,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.emoji_events,
                                size: 43,
                                color: MyApp.darkGreen,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '랭킹',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.darkGreen,
                                      ),
                                    ),
                                    const Text(
                                      '현재 내 포인트',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: MyApp.textGray,
                                      ),
                                    ),
                                    Text(
                                      '${user?.totalPoints ?? 0} P',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 28,
                                color: MyApp.darkGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 금연하기 카드
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onNavigateTab(1), // Đến trang AI 맞춤 추천
                        child: Container(
                          height: 110,
                          margin: const EdgeInsets.fromLTRB(3, 3, 6, 5),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: MyApp.green,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/smoke_free.png',
                                width: 44,
                                height: 44,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.smoke_free,
                                  size: 40,
                                  color: MyApp.cream,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '금연하기',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.cream,
                                      ),
                                    ),
                                    Text(
                                      'AI 맞춤 운동 시작!',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: MyApp.cream,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: MyApp.cream,
                                size: 28,
                              ),
                            ],
                          ),
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
                    color: MyApp.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: MyApp.borderGreen,
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
                            color: MyApp.darkGreen,
                            size: 20,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            '운동 현황',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyApp.darkGreen,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: MyApp.lightGreen,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '오늘도 화이팅!',
                              style: TextStyle(fontSize: 13),
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
                                  color: MyApp.litGreen,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.directions_walk,
                                      size: 38,
                                      color: MyApp.darkGreen,
                                    ),
                                    SizedBox(width: 7),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '오늘의 걸음 수',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: MyApp.textGray,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          '8,431 걸음',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: MyApp.darkGreen,
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
                                  color: MyApp.litGreen,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.local_fire_department,
                                      size: 34,
                                      color: MyApp.darkGreen,
                                    ),
                                    SizedBox(width: 7),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '소모 칼로리',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: MyApp.textGray,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          '325 kcal',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: MyApp.darkGreen,
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
                    color: const Color.fromRGBO(239, 246, 220, 1.0),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: MyApp.borderGreen,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.eco, color: MyApp.darkGreen, size: 23),
                          SizedBox(width: 4),
                          Text(
                            '금연의 이로움',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: MyApp.darkGreen,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        '금연을 시작한 순간부터 몸은 회복되기 시작해요.',
                        style: TextStyle(fontSize: 10, color: MyApp.textGray),
                      ),
                      SizedBox(height: 12),
                      _BenefitItem(
                        time: '20분',
                        text: '혈압과 심장박동이 정상으로 돌아오고 손발 체온이 상승합니다.',
                      ),
                      _BenefitItem(
                        time: '12시간',
                        text: '혈중 산소량이 정상으로 올라가고 일산화탄소 수치가 정상화됩니다.',
                      ),
                      _BenefitItem(
                        time: '2주~3개월',
                        text: '혈액순환이 원활해지고 폐 기능이 향상됩니다.',
                      ),
                      _BenefitItem(
                        time: '1년',
                        text: '심장마비 및 심장병 발생 위험이 감소합니다.',
                      ),
                      _BenefitItem(
                        time: '10년',
                        text: '폐암 및 각종 암 위험이 크게 낮아집니다.',
                      ),
                      _BenefitItem(
                        time: '15년',
                        text: '심혈관질환 위험이 비흡연자 수준으로 낮아집니다.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 65,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23,
              color: selected ? MyApp.darkGreen : Colors.black45,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? MyApp.darkGreen : Colors.black45,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}