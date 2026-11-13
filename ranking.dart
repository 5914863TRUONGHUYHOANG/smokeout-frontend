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
      title: 'Hamnyangi Ranking Test',
      theme: ThemeData(
        // 전체 앱의 기본 배경색 설정 (세이지 그린 톤)
        scaffoldBackgroundColor: const Color(0xFFF4F6F0),
      ),
      // 앱을 실행하자마자 랭킹 화면이 바로 보이도록 설정
      home: const RankingScreen(),
    );
  }
}

// -------------------------------------------------------------
// 랭킹 화면 (RankingScreen) 통합 코드
// -------------------------------------------------------------
class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool _isThisWeek = true; // 이번 주 / 전체 탭 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F0), // 전체 배경색 (세이지 그린 톤)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 타이틀 및 원본 디자인과 완벽히 일치하는 산/언덕 배경 + 고양이 캐릭터 영역
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.emoji_events, color: Color(0xFF4A5D3F), size: 28),
                          SizedBox(width: 8),
                          Text(
                            '랭킹',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B4E32),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '운동하고 포인트를 모아보세요!',
                        style: TextStyle(fontSize: 13, color: Color(0xFF7A8B6F)),
                      ),
                    ],
                  ),
                  // 우측 상단: 부드러운 언덕 레이어 + 햄냥이 캐릭터
                  SizedBox(
                    width: 100,
                    height: 70,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE2EAD8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 80,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD4E2C7),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(40),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                              'assets/running_cat.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.pets, color: Color(0xFF4A5D3F), size: 40);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 이번 주 / 전체 토글 버튼 (세이지 그린 스타일)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2EAD8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isThisWeek = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _isThisWeek ? const Color(0xFF4A5D3F) : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            '이번 주',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isThisWeek ? Colors.white : const Color(0xFF7A8B6F),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isThisWeek = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !_isThisWeek ? const Color(0xFF4A5D3F) : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            '전체',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !_isThisWeek ? Colors.white : const Color(0xFF7A8B6F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 상위 1, 2, 3위 포디움 영역
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTopRankItem(rank: '2', name: '하늘', score: '850 P', color: const Color(0xFF8FA182), radius: 28),
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: _buildFirstRankItem(name: '지민', score: '1,320 P'),
                  ),
                  _buildTopRankItem(rank: '3', name: '유나', score: '780 P', color: const Color(0xFFB5A28D), radius: 28),
                ],
              ),
              const SizedBox(height: 20),

              // 4위부터 순위 리스트 (화이트 카드 백그라운드)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildRankListTile(rank: 4, name: '민지', score: '720 P'),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F4EC)),
                    _buildRankListTile(rank: 5, name: '서준', score: '690 P'),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F4EC)),
                    
                    // 내 순위 (6위 햄냥이 - 이름 변경 및 강조)
                    Container(
                      color: const Color(0xFFE5EFE2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              child: Text('6', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF3B4E32))),
                            ),
                            const SizedBox(width: 20),
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFF4A5D3F),
                              child: Icon(Icons.pets, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3B4E32),
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: const Text('나', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 6),
                                const Text('햄냥이', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B4E32))),
                              ],
                            ),
                            const Spacer(),
                            const Text('650 P', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B4E32))),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F4EC)),
                    _buildRankListTile(rank: 7, name: '지우', score: '620 P'),
                    const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF0F4EC)),
                    _buildRankListTile(rank: 8, name: '다현', score: '580 P'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 하단 나의 포인트 배너 (진한 세이지 그린)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A5D3F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.amber, size: 36),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('나의 포인트', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            SizedBox(height: 2),
                            Text('조금만 더 힘내세요!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const Text('650 P >', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // 하단 네비게이션 바: 홈, 운동, 랭킹, 금연, MY
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2EAD8), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: 2, // 랭킹 탭이 3번째(index 2)
          selectedItemColor: const Color(0xFF4A5D3F),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: '운동'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
            BottomNavigationBarItem(icon: Icon(Icons.smoke_free), label: '금연'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'MY'),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstRankItem({required String name, required String score}) {
    return Column(
      children: [
        const Icon(Icons.emoji_events, color: Colors.amber, size: 30),
        const SizedBox(height: 4),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFF4A5D3F),
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Color(0xFFE5EFE2),
                child: Icon(Icons.pets, color: Color(0xFF4A5D3F), size: 32),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: const Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B4E32))),
        const SizedBox(height: 2),
        Text(score, style: const TextStyle(fontSize: 13, color: Color(0xFF7A8B6F))),
      ],
    );
  }

  Widget _buildTopRankItem({
    required String rank,
    required String name,
    required String score,
    required Color color,
    required double radius,
  }) {
    return Column(
      children: [
        const SizedBox(height: 34),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: color.withOpacity(0.3),
              child: CircleAvatar(
                radius: radius - 3,
                backgroundColor: color,
                child: const Icon(Icons.person, color: Colors.white, size: 24),
              ),
            ),
            CircleAvatar(
              radius: 11,
              backgroundColor: Colors.white,
              child: Text(rank, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: color)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B4E32))),
        const SizedBox(height: 2),
        Text(score, style: const TextStyle(fontSize: 13, color: Color(0xFF7A8B6F))),
      ],
    );
  }

  Widget _buildRankListTile({required int rank, required String name, required String score}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text('$rank', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFF0F4EC),
            child: Icon(Icons.person, color: Color(0xFF8FA182), size: 20),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF3B4E32))),
          const Spacer(),
          Text(score, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4A5D3F))),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
