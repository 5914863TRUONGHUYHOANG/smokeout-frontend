// ignore_for_file: deprecated_member_use, prefer_const_constructors

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
      title: 'Smoke Out',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F5E8), // Background light greenish yellow
        fontFamily: 'Pretendard', // Or system font
      ),
      home: const MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool isExerciseNotificationOn = true;
  bool isSmokeOutNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Leaves Pattern Effect (Simulated with Gradient/Decoration)
          Positioned.fill(
            child: Container(
              color: const Color(0xFFF3F6EB),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title Section
                  Row(
                    children: const [
                      Text(
                        'Smoke Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5E8B45),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.eco, color: Color(0xFF5E8B45), size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'MY',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF5E8B45),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '나의 금연 여정을 확인해 보세요!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 1. Profile Card Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar with Camera Icon
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundColor: Color(0xFFE5EDD8),
                              child: Icon(Icons.person, size: 48, color: Color(0xFF7CA065)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF5E8B45),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        
                        // User Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    ' 사용자 ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.eco, color: Color(0xFF7CA065), size: 16),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECF3E5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.eco, size: 14, color: Color(0xFF5E8B45)),
                                    SizedBox(width: 4),
                                    Text(
                                      '금연 도전 중',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF5E8B45),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: const [
                                  Text(
                                    '오늘도 건강한 하루 ',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                                  ),
                                  Icon(Icons.eco, size: 12, color: Color(0xFF7CA065)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black45),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Exercise Record Section (운동 기록)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
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
                            Row(
                              children: const [
                                Icon(Icons.directions_run, color: Color(0xFF5E8B45), size: 26),
                                SizedBox(width: 8),
                                Text(
                                  '나의 운동 기록',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECF3E5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    '전체 보기',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF5E8B45),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFF5E8B45)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // 3 Stat Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Steps
                            _buildStatItem(
                              icon: Icons.directions_walk,
                              value: '8,431 걸음',
                              label: '오늘의 걸음 수',
                            ),
                            _buildDivider(),
                            // Calories
                            _buildStatItem(
                              icon: Icons.local_fire_department,
                              value: '125.3 kcal',
                              label: '소모 칼로리',
                            ),
                            _buildDivider(),
                            // Time
                            _buildStatItem(
                              icon: Icons.fitness_center,
                              value: '30 분',
                              label: '운동 시간',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Notification Settings Section (알림 설정)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.notifications, color: Color(0xFF5E8B45), size: 24),
                            SizedBox(width: 8),
                            Text(
                              '알림 설정',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 12),

                        // Exercise Switch
                        Row(
                          children: [
                            const Icon(Icons.directions_run, color: Color(0xFF5E8B45), size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '운동 알림',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '운동 시작을 알려드려요!',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: isExerciseNotificationOn,
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF5E8B45),
                              onChanged: (val) {
                                setState(() {
                                  isExerciseNotificationOn = val;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 12),

                        // Smoke Out Switch
                        Row(
                          children: [
                            const Icon(Icons.smoke_free, color: Color(0xFF5E8B45), size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '금연 알림',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '금연을 응원하는 알림을 받아보세요!',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: isSmokeOutNotificationOn,
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF5E8B45),
                              onChanged: (val) {
                                setState(() {
                                  isSmokeOutNotificationOn = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Encouragement Text
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '지금도 충분히 잘하고 있어요! ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7CA065),
                          ),
                        ),
                        Icon(Icons.favorite, color: Color(0xFF7CA065), size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // MY selected
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5E8B45),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: '운동',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: '랭킹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
      ),
    );
  }

  // Stat item widget helper
  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF5E8B45), size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF757575),
          ),
        ),
      ],
    );
  }

  // Divider between stats helper
  Widget _buildDivider() {
    return Container(
      height: 35,
      width: 1,
      color: const Color(0xFFEEEEEE),
    );
  }
}