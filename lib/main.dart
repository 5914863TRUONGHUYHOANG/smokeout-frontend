import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hamnyangi Settings',
      theme: ThemeData(
        primaryColor: const Color(0xFF556B2F),
        scaffoldBackgroundColor: const Color(0xFFF4F6F0),
        fontFamily: 'sans-serif',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of 5 tabs for the Bottom Navigation Bar
  final List<Widget> _pages = [
    const SettingsScreen(), // Settings screen as the main home view here
    const ExerciseScreen(),
    const RankingScreen(),
    const NoSmokingScreen(),
    const MyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: '운동'), // Running icon
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
          BottomNavigationBarItem(icon: Icon(Icons.smoke_free), label: '금연'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MY'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF3B5323),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// -------------------------------------------------------------
// Settings Screen (설정 화면) with Layered Hills Background and running_cat.png
// -------------------------------------------------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F0),
      body: Stack(
        children: [
          // Upper Header Layered Mountain Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: CustomPaint(
              painter: LayeredHillsPainter(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title (설정) & running_cat.png Asset
                  Row(
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
                            ),
                          ),
                        ],
                      ),
                      // Running cat image asset in the header
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(
                          'assets/running_cat.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.pets, color: Color(0xFF3B5323), size: 40);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Profile Card with Name: 햄냥이 and running_cat.png avatar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EFE2),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF556B2F),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/running_cat.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.pets, color: Colors.white, size: 30);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '햄냥이', // Updated name as requested
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E1B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '내 프로필 관리',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Non-Smoking Settings Section (금연 설정)
                  const Text(
                    '금연 설정',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.smoke_free, color: Color(0xFF3B5323)),
                          title: Text('금연 목표'),
                          trailing: Text('30일 >', style: TextStyle(color: Colors.grey)),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.calendar_today, color: Color(0xFF3B5323)),
                          title: Text('금연 시작일'),
                          trailing: Text('2025.09.01 >', style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Notification Settings Section (알림 설정)
                  const Text(
                    '알림 설정',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          secondary: const Icon(Icons.directions_run, color: Color(0xFF3B5323)),
                          title: const Text('운동 알림'),
                          value: true,
                          activeThumbColor: const Color(0xFF556B2F),
                          onChanged: (bool value) {},
                        ),
                        const Divider(height: 1),
                        SwitchListTile(
                          secondary: const Icon(Icons.smoke_free, color: Color(0xFF3B5323)),
                          title: const Text('금연 알림'),
                          value: true,
                          activeThumbColor: const Color(0xFF556B2F),
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Other Settings Section (기타)
                  const Text(
                    '기타',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.lock_outline, color: Color(0xFF3B5323)),
                          title: Text('개인정보'),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ),
                        Divider(height: 1),
                        ListTile(
                          leading: Icon(Icons.info_outline, color: Color(0xFF3B5323)),
                          title: Text('앱 정보'),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button (로그아웃)
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Color(0xFF556B2F)),
                      label: const Text(
                        '로그아웃',
                        style: TextStyle(color: Color(0xFF556B2F), fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE5EFE2),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// Custom Painter for Layered Mountain Background Header
// -------------------------------------------------------------
class LayeredHillsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Back hill layer
    final paintBack = Paint()
      ..color = const Color(0xFFD6E5D0)
      ..style = PaintingStyle.fill;

    final pathBack = Path();
    pathBack.lineTo(0, size.height - 60);
    pathBack.quadraticBezierTo(size.width * 0.3, size.height - 20, size.width * 0.7, size.height - 80);
    pathBack.quadraticBezierTo(size.width * 0.9, size.height - 100, size.width, size.height - 50);
    pathBack.lineTo(size.width, 0);
    pathBack.close();
    canvas.drawPath(pathBack, paintBack);

    // Front hill layer
    final paintFront = Paint()
      ..color = const Color(0xFFC4D9BC)
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

// Placeholder Screens for other Tabs
class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('운동 (Exercise)')));
}

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('랭킹 (Ranking)')));
}

class NoSmokingScreen extends StatelessWidget {
  const NoSmokingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('금연 (No Smoking)')));
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('MY')));
}