
import 'package:flutter/material.dart';
import 'setting.dart' show SettingsScreen;
import 'exercise.dart' show ExerciseScreen;

void main() {
  runApp(const MyApp());
}

const Color green = Color(0xFF5E8B45);
const Color lightGreen = Color(0xFFECF3E5);
const Color background = Color(0xFFF3F6EB);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Out',
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: green),
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
  String nickname = '사용자';
  String email = 'user@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Smoke Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.eco, color: green),
                    ],
                  ),

                  // Settings Button
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: green,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 4),

              const Text(
                'MY',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: green,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                '나의 금연 여정을 확인해 보세요!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(
                          nickname: nickname,
                          email: email,
                          onSave: (newNickname, newEmail) {
                            setState(() {
                              nickname = newNickname;
                              email = newEmail;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 34,
                        backgroundColor: Color(0xFFE5EDD8),
                        child: Icon(
                          Icons.person,
                          size: 46,
                          color: Color(0xFF7CA065),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  nickname,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.eco,
                                  color: green,
                                  size: 16,
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '🌿 금연 도전 중',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              '오늘도 건강한 하루 🌿',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // My Smoking Record
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2E7),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '나의 금연 기록',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: _smokingStat(
                            '25일',
                            '금연 유지 일수',
                          ),
                        ),
                        Expanded(
                          child: _smokingStat(
                            '50,000원',
                            '절약한 금액',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // My Activity
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '나의 활동',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _activityItem(
                      Icons.directions_walk,
                      '총 운동 횟수',
                      '18회',
                    ),

                    const Divider(
                      height: 30,
                      color: Color(0xFFEEEEEE),
                    ),

                    _activityItem(
                      Icons.access_time,
                      '누적 운동 시간',
                      '360분',
                    ),

                    const Divider(
                      height: 30,
                      color: Color(0xFFEEEEEE),
                    ),

                    _activityItem(
                      Icons.emoji_events_outlined,
                      '나의 랭킹',
                      '3위',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Encouragement
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '지금도 충분히 잘하고 있어요! ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7CA065),
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color(0xFF7CA065),
                      size: 16,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),

        onTap: (index) {
          if (index == 0) {
            // 홈 화면으로 돌아가기
            Navigator.popUntil(context, ((route) => route.isFirst));
          } else if (index == 1) {
            // 운동 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExerciseScreen(),
              ),
            );
          }
        },
        
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

  // Card Decoration
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Smoking Statistics
  Widget _smokingStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4F805C),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Activity Item
  Widget _activityItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: const Color(0xFF5D8464),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}


// ==========================================
// PROFILE SCREEN
// ==========================================

class ProfileScreen extends StatefulWidget {
  final String nickname;
  final String email;
  final Function(String, String) onSave;

  const ProfileScreen({
    super.key,
    required this.nickname,
    required this.email,
    required this.onSave,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nicknameController;
  late TextEditingController emailController;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    nicknameController =
        TextEditingController(text: widget.nickname);

    emailController =
        TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (nicknameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('닉네임과 이메일을 입력해 주세요.'),
        ),
      );
      return;
    }

    widget.onSave(
      nicknameController.text.trim(),
      emailController.text.trim(),
    );

    setState(() {
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('프로필이 수정되었습니다!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const Text(
          '프로필 관리',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: const BackButton(color: Colors.black87),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Profile Image
            Stack(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFFE5EDD8),
                  child: Icon(
                    Icons.person,
                    size: 75,
                    color: Color(0xFF7CA065),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '사진 선택 기능은 이미지 업로드 연동이 필요합니다.',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: const BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            // Nickname
            _profileField(
              '닉네임 (Nickname)',
              nicknameController,
              Icons.person_outline,
            ),

            const SizedBox(height: 22),

            // Email
            _profileField(
              '이메일 (Email)',
              emailController,
              Icons.email_outlined,
            ),

            const SizedBox(height: 35),

            // Edit / Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                onPressed: () {
                  if (isEditing) {
                    saveProfile();
                  } else {
                    setState(() {
                      isEditing = true;
                    });
                  }
                },

                child: Text(
                  isEditing ? '저장하기' : '프로필 수정',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if (isEditing) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() {
                    nicknameController.text = widget.nickname;
                    emailController.text = widget.email;
                    isEditing = false;
                  });
                },
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _profileField(
    String title,
    TextEditingController controller,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          readOnly: !isEditing,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: green),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
