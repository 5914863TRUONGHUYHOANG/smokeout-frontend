import 'package:flutter/material.dart';

void main() {
  runApp(const HamNyangApp());
}

// -------------------------------------------------------------
// 앱 글로벌 테마 & 엔트리 포인트
// -------------------------------------------------------------
class HamNyangApp extends StatelessWidget {
  const HamNyangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '햄냥이 설정',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF556B2F),
        scaffoldBackgroundColor: const Color(0xFFF4F6F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF556B2F),
          primary: const Color(0xFF3B5323),
          secondary: const Color(0xFF556B2F),
          surface: const Color(0xFFF4F6F0),
        ),
        fontFamily: 'sans-serif',
      ),
      home: const MainScreen(),
    );
  }
}

// -------------------------------------------------------------
// 메인 스크린 (하단 네비게이션 & 애니메이션 탭 전환)
// -------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    SettingsScreen(),
    ExerciseScreen(),
    RankingScreen(),
    NoSmokingScreen(),
    MyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF3B5323),
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_run_outlined), activeIcon: Icon(Icons.directions_run), label: '운동'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), activeIcon: Icon(Icons.emoji_events), label: '랭킹'),
            BottomNavigationBarItem(icon: Icon(Icons.smoke_free_outlined), activeIcon: Icon(Icons.smoke_free), label: '금연'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'MY'),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 고급 설정 화면 (Settings Screen)
// -------------------------------------------------------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 알림 토글 상태 관리
  bool _exerciseNotification = true;
  bool _smokingNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. 상단 감성 그라데이션 커스텀 산 디자인 배경
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: CustomPaint(
              painter: LayeredHillsPainter(),
            ),
          ),
          
          // 2. 메인 컨텐츠 영역
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 앱바 및 상단 이미지 영역
                  _buildHeader(),
                  const SizedBox(height: 16),

                  // 내 프로필 카드
                  _buildProfileCard(),
                  const SizedBox(height: 24),

                  // 금연 설정 섹션
                  _buildSectionHeader('금연 설정'),
                  const SizedBox(height: 10),
                  _buildSettingGroupCard([
                    ListTile(
                      leading: const Icon(Icons.smoke_free, color: Color(0xFF3B5323)),
                      title: const Text('금연 목표', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('30일', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        ],
                      ),
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F0F0)),
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Color(0xFF3B5323)),
                      title: const Text('금연 시작일', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('2025.09.01', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // 알림 설정 섹션
                  _buildSectionHeader('알림 설정'),
                  const SizedBox(height: 10),
                  _buildSettingGroupCard([
                    SwitchListTile(
                      secondary: const Icon(Icons.directions_run, color: Color(0xFF3B5323)),
                      title: const Text('운동 알림', style: TextStyle(fontWeight: FontWeight.w500)),
                      value: _exerciseNotification,
                      activeColor: const Color(0xFF556B2F),
                      onChanged: (bool value) {
                        setState(() {
                          _exerciseNotification = value;
                        });
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F0F0)),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_active_outlined, color: Color(0xFF3B5323)),
                      title: const Text('금연 응원 알림', style: TextStyle(fontWeight: FontWeight.w500)),
                      value: _smokingNotification,
                      activeColor: const Color(0xFF556B2F),
                      onChanged: (bool value) {
                        setState(() {
                          _smokingNotification = value;
                        });
                      },
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // 기타 섹션
                  _buildSectionHeader('기타'),
                  const SizedBox(height: 10),
                  _buildSettingGroupCard([
                    ListTile(
                      leading: const Icon(Icons.lock_outline, color: Color(0xFF3B5323)),
                      title: const Text('개인정보 보호', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F0F0)),
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: Color(0xFF3B5323)),
                      title: const Text('앱 정보 및 버전', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 32),

                  // 로그아웃 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // 로그아웃 대화상자 노출 예시
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('로그아웃'),
                            content: const Text('정말 로그아웃 하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('취소', style: TextStyle(color: Colors.grey)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('확인', style: TextStyle(color: Color(0xFF556B2F))),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Color(0xFF3B5323)),
                      label: const Text(
                        '로그아웃',
                        style: TextStyle(
                          color: Color(0xFF3B5323),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5EFE2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 상단 헤더 컴포넌트
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.settings, color: Color(0xFF3B5323), size: 28),
            SizedBox(width: 8),
            Text(
              '설정',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B5323),
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 70,
          height: 70,
          child: Image.asset(
            'assets/running_cat.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.pets, color: Color(0xFF3B5323), size: 36),
              );
            },
          ),
        ),
      ],
    );
  }

  // 프로필 카드 컴포넌트
  Widget _buildProfileCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EFE2).withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF556B2F),
                child: Icon(
                  Icons.person,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '햄냥이',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E1B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '내 프로필 관리하기',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B8E23),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF556B2F)),
            ],
          ),
        ),
      ),
    );
  }

  // 섹션 타이틀 컴포넌트
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3B5323),
      ),
    );
  }

  // 설정 그룹 카드 컴포넌트
  Widget _buildSettingGroupCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// -------------------------------------------------------------
// 고도화된 상단 레이어드 산 모양 커스텀 페인터 (그라데이션 효과)
// -------------------------------------------------------------
class LayeredHillsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 뒷 산 (그라데이션 칠)
    final paintBack = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE2EEDF), Color(0xFFD6E5D0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final pathBack = Path();
    pathBack.lineTo(0, size.height - 60);
    pathBack.quadraticBezierTo(size.width * 0.3, size.height - 20, size.width * 0.7, size.height - 80);
    pathBack.quadraticBezierTo(size.width * 0.9, size.height - 100, size.width, size.height - 50);
    pathBack.lineTo(size.width, 0);
    pathBack.close();
    canvas.drawPath(pathBack, paintBack);

    // 앞 산 (그라데이션 칠)
    final paintFront = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD0E2C8), Color(0xFFC4D9BC)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final pathFront = Path();
    pathFront.lineTo(0, size.height - 25);
    pathFront.quadraticBezierTo(size.width * 0.25, size.height - 60, size.width * 0.6, size.height - 35);
    pathFront.quadraticBezierTo(size.width * 0.85, size.height - 10, size.width, size.height - 45);
    pathFront.lineTo(size.width, 0);
    pathFront.close();
    canvas.drawPath(pathFront, paintFront);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -------------------------------------------------------------
// 기타 탭 화면 플레이스홀더 (공통 레이아웃 템플릿)
// -------------------------------------------------------------
class BasePlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const BasePlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3B5323))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: const Color(0xFF556B2F).withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              '$title 준비 중입니다.',
              style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  @override
  Widget build(BuildContext context) => const BasePlaceholderScreen(title: '운동', icon: Icons.directions_run);
}

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});
  @override
  Widget build(BuildContext context) => const BasePlaceholderScreen(title: '랭킹', icon: Icons.emoji_events);
}

class NoSmokingScreen extends StatelessWidget {
  const NoSmokingScreen({super.key});
  @override
  Widget build(BuildContext context) => const BasePlaceholderScreen(title: '금연', icon: Icons.smoke_free);
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
  @override
  Widget build(BuildContext context) => const BasePlaceholderScreen(title: 'MY', icon: Icons.person);
}
