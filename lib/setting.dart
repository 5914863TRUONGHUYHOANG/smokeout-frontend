import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F0),
      body: Stack(
        children: [
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
                      // 상단 오른쪽 고양이 로고 (유지)
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
                  
                  // 프로필 카드 (추후 원하는 이미지로 쉽게 교체 가능하도록 수정)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EFE2),
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
                        // [프로필 사진 영역] 추후 Image.asset('원하는경로') 또는 NetworkImage 로 변경 가능
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF556B2F),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.person, 
                            color: Colors.white, 
                            size: 30,
                          ), // 추후 사진이 들어갈 수 있는 기본 아이콘 형태 (원하시면 Image로 교체 가능)
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
                          activeColor: const Color(0xFF556B2F),
                          onChanged: (bool value) {},
                        ),
                        const Divider(height: 1),
                        SwitchListTile(
                          secondary: const Icon(Icons.smoke_free, color: Color(0xFF3B5323)),
                          title: const Text('금연 알림'),
                          value: true,
                          activeColor: const Color(0xFF556B2F),
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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

// 배경 산 모양 Custom Painter
class LayeredHillsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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