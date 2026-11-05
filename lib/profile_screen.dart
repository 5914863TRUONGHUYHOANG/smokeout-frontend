import 'package:flutter/material.dart';
import 'exercise.dart';
import 'login.dart' show LoginScreen;
import 'main.dart';
import 'setting_screen.dart';

class UserProfileData {
  final String nickname;
  final String email;
  final String fitnessLevel;
  final int totalPoints;
  final int smokeFreeDays;
  final List<String> healthFlags;
  final bool milestonesClaimed;

  const UserProfileData({
    required this.nickname,
    required this.email,
    required this.fitnessLevel,
    required this.totalPoints,
    this.smokeFreeDays = 15,
    this.healthFlags = const [],
    this.milestonesClaimed = false,
  });

  UserProfileData copyWith({
    String? nickname,
    String? email,
    String? fitnessLevel,
    int? totalPoints,
    int? smokeFreeDays,
    List<String>? healthFlags,
    bool? milestonesClaimed,
  }) {
    return UserProfileData(
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      totalPoints: totalPoints ?? this.totalPoints,
      smokeFreeDays: smokeFreeDays ?? this.smokeFreeDays,
      healthFlags: healthFlags ?? this.healthFlags,
      milestonesClaimed: milestonesClaimed ?? this.milestonesClaimed,
    );
  }
}

const UserProfileData _defaultUserProfile = UserProfileData(
  nickname: 'SmokeFreeHero',
  email: 'test@gmail.com',
  fitnessLevel: 'BEGINNER',
  totalPoints: 1250,
  smokeFreeDays: 15,
);

final ValueNotifier<UserProfileData?> userProfileNotifier =
    ValueNotifier<UserProfileData?>(_defaultUserProfile);

void restoreDefaultUserProfile() {
  userProfileNotifier.value = _defaultUserProfile;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color card = Color.fromRGBO(253, 253, 246, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
  static const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);

  bool _isClaiming = false;

  Future<void> _claimMilestones() async {
    final user = userProfileNotifier.value;
    if (user == null) return;

    setState(() => _isClaiming = true);
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    final bool newlyGranted = !user.milestonesClaimed;
    final int days = user.smokeFreeDays;
    if (newlyGranted) {
      userProfileNotifier.value = user.copyWith(
        totalPoints: user.totalPoints + 300,
        milestonesClaimed: true,
      );
    }

    setState(() => _isClaiming = false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🎉 금연 마일스톤 달성!'),
        content: Text(
          newlyGranted
              ? '$days일 금연 성공!\n3개의 마일스톤 보상(+300 P)을 획득했습니다.'
              : '현재 $days일 금연 중입니다.\n새로운 달성 마일스톤이 아직 없습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _openHealthEditDialog() {
    final user = userProfileNotifier.value;
    if (user == null) return;

    String selectedLevel = user.fitnessLevel;
    final List<String> selectedFlags = List<String>.from(user.healthFlags);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('건강 상태 및 체력 설정'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('운동 체력 수준:'),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: selectedLevel,
                      items: const [
                        DropdownMenuItem(
                          value: 'BEGINNER',
                          child: Text('초급 (BEGINNER)'),
                        ),
                        DropdownMenuItem(
                          value: 'INTERMEDIATE',
                          child: Text('중급 (INTERMEDIATE)'),
                        ),
                        DropdownMenuItem(
                          value: 'ADVANCED',
                          child: Text('고급 (ADVANCED)'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setModalState(() => selectedLevel = val);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text('주의 건강 상태 (다중 선택 가능):'),
                    CheckboxListTile(
                      title: const Text('고혈압 (HYPERTENSION)'),
                      value: selectedFlags.contains('HYPERTENSION'),
                      onChanged: (val) {
                        setModalState(() {
                          val == true
                              ? selectedFlags.add('HYPERTENSION')
                              : selectedFlags.remove('HYPERTENSION');
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('천식 (ASTHMA)'),
                      value: selectedFlags.contains('ASTHMA'),
                      onChanged: (val) {
                        setModalState(() {
                          val == true
                              ? selectedFlags.add('ASTHMA')
                              : selectedFlags.remove('ASTHMA');
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('관절 통증 (JOINT_PAIN)'),
                      value: selectedFlags.contains('JOINT_PAIN'),
                      onChanged: (val) {
                        setModalState(() {
                          val == true
                              ? selectedFlags.add('JOINT_PAIN')
                              : selectedFlags.remove('JOINT_PAIN');
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: darkGreen),
                  onPressed: () {
                    userProfileNotifier.value = user.copyWith(
                      fitnessLevel: selectedLevel,
                      healthFlags: selectedFlags,
                    );
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('건강 정보가 저장되었습니다.')),
                    );
                  },
                  child: const Text('저장', style: TextStyle(color: cream)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserProfileData?>(
      valueListenable: userProfileNotifier,
      builder: (context, user, _) {
        return Scaffold(
          backgroundColor: cream,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: cream,
            elevation: 0,
            title: const Text(
              '내 정보 (My Page)',
              style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: darkGreen),
                tooltip: '설정',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingScreen()),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: user == null
                ? _buildLoggedOutView()
                : _buildLoggedInView(user),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 68,
            color: cream,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProfileBottomItem(
                  icon: Icons.home,
                  label: '홈',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                ),
                _ProfileBottomItem(
                  icon: Icons.directions_run,
                  label: '운동',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ExerciseScreen()),
                    );
                  },
                ),
                const _ProfileBottomItem(
                  icon: Icons.emoji_events_outlined,
                  label: '랭킹',
                ),
                const _ProfileBottomItem(
                  icon: Icons.person_outline,
                  label: 'MY',
                  selected: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoggedOutView() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderGreen, width: 1.5),
        ),
        child: Column(
          children: [
            const Icon(Icons.account_circle, size: 80, color: green),
            const SizedBox(height: 16),
            const Text(
              '로그인이 필요합니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '계정에 로그인하여 금연 기록과 포인트를 확인하세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '로그인 / 회원가입',
                style: TextStyle(color: cream, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInView(UserProfileData user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Profile Header Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderGreen, width: 1.5),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: lightGreen,
                child: Text(
                  user.nickname.isNotEmpty
                      ? user.nickname[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nickname,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '체력: ${user.fitnessLevel}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Points Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: lightGreen.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: green, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.stars, color: darkGreen, size: 28),
                  SizedBox(width: 10),
                  Text(
                    '내 누적 포인트',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
              Text(
                '${user.totalPoints} P',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Action Buttons
        Card(
          color: card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: borderGreen),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.military_tech_outlined,
                  color: darkGreen,
                ),
                title: const Text('금연 마일스톤 보상 수령'),
                subtitle: const Text('금연 일수 달성에 따른 포인트 보상 확인'),
                trailing: _isClaiming
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.chevron_right),
                onTap: _claimMilestones,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(
                  Icons.health_and_safety_outlined,
                  color: darkGreen,
                ),
                title: const Text('건강 상태 및 체력 변경'),
                subtitle: const Text('AI 맞춤 추천을 위한 안전 필터 설정'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openHealthEditDialog,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.settings_outlined, color: darkGreen),
                title: const Text('앱 설정'),
                subtitle: const Text('알림, 테마 및 계정 설정'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingScreen()),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Logout Button
        OutlinedButton.icon(
          onPressed: () {
            userProfileNotifier.value = null;
          },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text(
            '로그아웃',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileBottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _ProfileBottomItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
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
    );
  }
}
