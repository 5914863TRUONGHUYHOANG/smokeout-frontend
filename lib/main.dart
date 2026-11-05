import 'package:flutter/material.dart';
import 'setting.dart'; // setting.dart 파일 연결

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '햄냥이 설정',
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

  // 하단 네비게이션 탭 5개 목록
  final List<Widget> _pages = [
    const SettingsScreen(), // 홈(설정) 화면
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
          BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: '운동'),
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

// 기타 탭 화면들 (Placeholder)
class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('운동 화면')));
}

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('랭킹 화면')));
}

class NoSmokingScreen extends StatelessWidget {
  const NoSmokingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('금연 화면')));
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('MY 화면')));
}