import 'package:flutter/material.dart';

import 'login.dart' show LoginScreen;
import 'home.dart' show HomeScreen;
import 'exercise.dart' show ExerciseScreen;
import 'my.dart' show MyScreen;
import 'ranking.dart' show RankingScreen;


// 앱의 진입점은 main.dart 한 곳에서 관리합니다.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Out',
      theme: ThemeData(
        scaffoldBackgroundColor: HomeScreen.cream,
        colorSchemeSeed: HomeScreen.darkGreen,
        fontFamily: 'sans',
        useMaterial3: true,
      ),
      // 기존 로그인 화면은 그대로 유지합니다.
      home: const LoginScreen(),
      // login.dart의 로그인 완료 코드는 '/home'으로 이동합니다.
      routes: {
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

// 홈 / 운동 / 랭킹 / MY를 같은 깊이의 탭으로 관리하는 공통 화면입니다.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(onGoToExercise: () => selectTab(1)),
      const ExerciseScreen(),
      const RankingScreen(), // 랭킹 페이지가 준비되면 교체
      const MyScreen(),
    ];
  }

  void selectTab(int index) {
    if (selectedIndex == index) return;
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeScreen.cream,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        padding: EdgeInsets.zero,
        color: const Color(0xFFF8F7F0),
        elevation: 0,
        child: Row(
          children: [
            _TabItem(
              icon: Icons.home,
              label: '홈',
              selected: selectedIndex == 0,
              onTap: () => selectTab(0),
            ),
            _TabItem(
              icon: Icons.directions_run,
              label: '운동',
              selected: selectedIndex == 1,
              onTap: () => selectTab(1),
            ),
            _TabItem(
              icon: Icons.emoji_events_outlined,
              label: '랭킹',
              selected: selectedIndex == 2,
              onTap: () => selectTab(2),
            ),
            _TabItem(
              icon: Icons.person_outline,
              label: 'MY',
              selected: selectedIndex == 3,
              onTap: () => selectTab(3),
            ),
          ],
        ),
      ),
    );
  }
}

// 기존의 호버/선택 색상을 공통으로 적용하는 하단 메뉴 버튼.
class _TabItem extends StatefulWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool isHovered = false;

  static const Color darkGreen = Color(0xFF3F5C2B);
  static const Color hoverGreen = Color(0xFFE8F0D7);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Material(
          color: isHovered ? hoverGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            hoverColor: Colors.transparent,
            splashColor: const Color(0xFFD6E5BF),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 24,
                    color: widget.selected ? darkGreen : Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.selected ? darkGreen : Colors.grey,
                      fontWeight:
                          widget.selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

