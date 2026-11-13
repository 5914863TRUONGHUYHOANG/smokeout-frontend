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
      title: '햄냥이 설정',
      theme: ThemeData(
        primaryColor: const Color(0xFF556B2F),
        scaffoldBackgroundColor: const Color(0xFFF4F6F0),
        fontFamily: 'sans-serif',
      ),
      home: const SettingsScreen(), // 앱을 켜면 설정 화면이 바로 나타남
    );
  }
}

// -------------------------------------------------------------
// 설정 화면 (Settings Screen) 통합 코드
// -------------------------------------------------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 타이틀 및 설명 영역
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '설정',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B5323),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '더 나은 금연과 운동을 위한 설정을 관리해요!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 프로필 카드 영역 (이름: 햄냥이)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    // 프로필 아바타 및 아이콘 영역
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFD6E5D0),
                      child: Icon(
                        Icons.person,
                        size: 32,
                        color: Color(0xFF556B2F),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
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
                        SizedBox(height: 2),
                        Text(
                          'hamnyangi@email.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5EFE2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 14, color: Color(0xFF556B2F)),
                          SizedBox(width: 4),
                          Text(
                            '프로필 수정',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF556B2F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 알림 설정 섹션
              Row(
                children: const [
                  Icon(Icons.notifications, color: Color(0xFF3B5323), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '알림 설정',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                ],
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
                      secondary: const Icon(Icons.notifications_active, color: Color(0xFF3B5323)),
                      title: const Text('운동 알림', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: const Text('추천 운동 및 운동 시간 알림을 받아요', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      value: true,
                      activeColor: const Color(0xFF556B2F),
                      onChanged: (bool value) {},
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.smoke_free, color: Color(0xFF3B5323)),
                      title: const Text('금연 알림', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: const Text('금연 상태와 팁을 알려드려요', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      value: true,
                      activeColor: const Color(0xFF556B2F),
                      onChanged: (bool value) {},
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.emoji_events, color: Color(0xFF3B5323)),
                      title: const Text('랭킹 알림', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: const Text('주간 랭킹 업데이트를 알려드려요', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      value: false,
                      activeColor: const Color(0xFF556B2F),
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 포인트 및 혜택 섹션
              Row(
                children: const [
                  Icon(Icons.star, color: Color(0xFF3B5323), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '포인트 및 혜택',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.amber, size: 36),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('보유 크레딧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(height: 2),
                        Text('지금까지 모은 크레딧을 확인해보세요!', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5EFE2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '250 P >',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3B5323)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 앱 정보 섹션
              Row(
                children: const [
                  Icon(Icons.settings_suggest, color: Color(0xFF3B5323), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '앱 정보',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B5323),
                    ),
                  ),
                ],
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
                      leading: Icon(Icons.info_outline, color: Color(0xFF3B5323)),
                      title: Text('버전 정보'),
                      trailing: Text('v1.0.0', style: TextStyle(color: Colors.grey)),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.privacy_tip_outlined, color: Color(0xFF3B5323)),
                      title: Text('개인정보 처리방침'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.support_agent, color: Color(0xFF3B5323)),
                      title: Text('고객센터'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 로그아웃 버튼 영역
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
    );
  }
}
