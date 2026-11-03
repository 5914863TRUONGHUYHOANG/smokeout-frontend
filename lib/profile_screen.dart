import 'package:flutter/material.dart';

void main() {
  runApp(const SmokeOutApp());
}

class SmokeOutApp extends StatelessWidget {
  const SmokeOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Out',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F9E9),
      ),
      home: const MainHomeScreen(),
    );
  }
}

const Color darkGreen = Color(0xFF315C29);
const Color mainGreen = Color(0xFF4D8039);
const Color lightGreen = Color(0xFFE5F0D1);
const Color paleGreen = Color(0xFFF5F9E9);
const Color grayText = Color(0xFF777B70);

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex = 0;

  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '확인',
              style: TextStyle(color: mainGreen),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: [
            buildHomeBody(), // 1. 홈
            const SimplePage(
              title: '운동 현황',
              subtitle: '오늘의 운동 기록을 확인해보세요!',
              icon: Icons.directions_run_rounded,
            ), // 2. 운동
            const SimplePage(
              title: '랭킹',
              subtitle: '금연 랭킹 순위를 확인해보세요!',
              icon: Icons.emoji_events_rounded,
            ), // 3. 랭킹
            const SimplePage(
              title: '금연하기',
              subtitle: '오늘도 금연을 성공해봐요!',
              icon: Icons.smoke_free_rounded,
            ), // 4. 금연
            const SimplePage(
              title: '커뮤니티',
              subtitle: '다른 사람들과 소통해보세요!',
              icon: Icons.forum_rounded,
            ), // 5. 커뮤니티 (추가된 탭)
            const SimplePage(
              title: 'MY (프로필)',
              subtitle: '나의 정보와 설정',
              icon: Icons.person_rounded,
            ), // 6. MY
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: darkGreen,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run_rounded),
            label: '운동',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_rounded),
            label: '랭킹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smoke_free_rounded),
            label: '금연',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_rounded),
            label: '소통',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'MY',
          ),
        ],
      ),
    );
  }

  Widget buildHomeBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 15),
          buildSmokeStatusCard(),
          const SizedBox(height: 15),
          buildRankingAndQuitRow(),
          const SizedBox(height: 15),
          buildExerciseStatusCard(),
          const SizedBox(height: 15),
          buildSmokeBenefitsCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Smoke Out',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.eco, color: mainGreen, size: 22),
                ],
              ),
              SizedBox(height: 4),
              Text(
                '조금씩 더 건강한 나를 위해',
                style: TextStyle(
                  fontSize: 13,
                  color: grayText,
                ),
              ),
            ],
          ),
          Text('🐱🌱', style: TextStyle(fontSize: 45)),
        ],
      ),
    );
  }

  Widget buildSmokeStatusCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.bar_chart, color: darkGreen, size: 20),
                  SizedBox(width: 6),
                  Text(
                    '금연 현황',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => showMessage('상세보기', '금연 상세 기록 화면입니다.'),
                child: const Text(
                  '상세보기 >',
                  style: TextStyle(
                    fontSize: 13,
                    color: grayText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildSmokeStatItem('금연한 일', '15일', '(2025.09.13)', Icons.calendar_today_rounded),
              Container(height: 35, width: 1, color: Colors.grey.shade200),
              buildSmokeStatItem('참은 담배', '300개비', '(2025.09.13)', Icons.smoke_free),
              Container(height: 35, width: 1, color: Colors.grey.shade200),
              buildSmokeStatItem('아낀 금액', '120,000원', '(1갑 4000원 기준)', Icons.savings_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSmokeStatItem(String title, String value, String sub, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: mainGreen),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: grayText)),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          sub,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildRankingAndQuitRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => showMessage('랭킹', '현재 나의 순위 정보입니다.'),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: mainGreen, size: 20),
                      SizedBox(width: 6),
                      Text(
                        '랭킹',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkGreen),
                      ),
                      Spacer(),
                      Icon(Icons.chevron_right, color: grayText, size: 20),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('현재 나의 순위', style: TextStyle(fontSize: 11, color: grayText)),
                  SizedBox(height: 2),
                  Text(
                    '1위',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: darkGreen,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: darkGreen.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => showMessage('금연하기', '오늘도 금연에 도전중입니다! 화이팅!'),
                child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.smoke_free, color: Colors.redAccent, size: 24),
                          Icon(Icons.chevron_right, color: Colors.white70, size: 20),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '금연하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '오늘도 금연 성공해요!',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExerciseStatusCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.directions_walk, color: darkGreen, size: 20),
                  SizedBox(width: 6),
                  Text(
                    '운동 현황',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '오늘도 화이팅!',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: darkGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: paleGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_walk, size: 16, color: mainGreen),
                          SizedBox(width: 4),
                          Text('오늘의 걸음 수', style: TextStyle(fontSize: 11, color: grayText)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '8,431 걸음',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: paleGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
                          SizedBox(width: 4),
                          Text('오늘의 소모 칼로리', style: TextStyle(fontSize: 11, color: grayText)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '125,345 kcal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSmokeBenefitsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.eco, color: mainGreen, size: 20),
              SizedBox(width: 6),
              Text(
                '금연의 이로움',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '금연을 시작한 순간부터 몸은 회복되기 시작해요.',
            style: TextStyle(fontSize: 12, color: grayText),
          ),
          const SizedBox(height: 15),
          buildBenefitItem('20분', '혈압과 심장박동이 정상으로 돌아오고 손발 체온이 상승합니다.'),
          const SizedBox(height: 8),
          buildBenefitItem('12시간', '혈중 산소량이 정상으로 올라가고 일산화탄소 수치가 정상화됩니다.'),
          const SizedBox(height: 8),
          buildBenefitItem('2주~3개월', '혈액순환이 원활해지고 폐 기능이 향상됩니다.'),
          const SizedBox(height: 8),
          buildBenefitItem('1년', '심장마비 및 심장병 발생 위험이 감소합니다.'),
          const SizedBox(height: 8),
          buildBenefitItem('10년', '폐암 및 각종 암 위험이 크게 낮아집니다.'),
        ],
      ),
    );
  }

  Widget buildBenefitItem(String badgeText, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 75,
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: mainGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badgeText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: grayText,
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: mainGreen, size: 75),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: grayText,
            ),
          ),
          const SizedBox(height: 20),
          const Text('🌱🐱', style: TextStyle(fontSize: 55)),
        ],
      ),
    );
  }
}