import 'package:flutter/material.dart';
void main() {
  runApp(const SmokeOutApp());
}

const cream = Color(0xFFF8F7E9);
const darkGreen = Color(0xFF3D5D2D);
const green = Color(0xFF587B3D);
const paleGreen = Color(0xFFEAF0D9);
const borderGreen = Color(0xFFD2DDBD);
const mutedText = Color(0xFF77796D);

class SmokeOutApp extends StatelessWidget {
  const SmokeOutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smoke Out',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _hidePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('로그인 요청을 준비했습니다.'),
      ),
    );

    // TODO: Connect to your backend login API.
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration _decoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFAAA99D),
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: green, size: 21),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFFFFEF8),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: borderGreen),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: borderGreen),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: green,
          width: 1.7,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    // Cute mascot header
                    const MascotHeader(),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        26, 25, 26, 28,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 430,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                '다시 만나요! 🍃',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: darkGreen,
                                ),
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                '오늘도 건강한 나를 위해 시작해요.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: mutedText,
                                ),
                              ),
                              const SizedBox(height: 25),

                              const FieldLabel('이메일'),
                              const SizedBox(height: 9),

                              TextFormField(
                                controller: _email,
                                keyboardType:
                                    TextInputType.emailAddress,
                                textInputAction:
                                    TextInputAction.next,
                                decoration: _decoration(
                                  hint: '이메일을 입력하세요',
                                  icon: Icons.mail_outline_rounded,
                                ),
                                validator: (value) {
                                  final text = value?.trim() ?? '';
                                  if (text.isEmpty) {
                                    return '이메일을 입력해 주세요.';
                                  }
                                  if (!RegExp(
                                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                  ).hasMatch(text)) {
                                    return '올바른 이메일을 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 19),
                              const FieldLabel('비밀번호'),
                              const SizedBox(height: 9),

                              TextFormField(
                                controller: _password,
                                obscureText: _hidePassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _login(),
                                decoration: _decoration(
                                  hint: '비밀번호를 입력하세요',
                                  icon: Icons.lock_outline_rounded,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword =
                                            !_hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                      _hidePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: mutedText,
                                      size: 21,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return '비밀번호를 입력해 주세요.';
                                  }
                                  if (value.length < 6) {
                                    return '비밀번호는 6자 이상 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => _message(
                                    '비밀번호 찾기 화면을 연결해 주세요.',
                                  ),
                                  child: const Text(
                                    '비밀번호 찾기',
                                    style: TextStyle(
                                      color: green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: green,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '로그인',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 21),

                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: borderGreen,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 13,
                                    ),
                                    child: Text(
                                      '아직 회원이 아니신가요?',
                                      style: TextStyle(
                                        color: mutedText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: borderGreen,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 17),

                              OutlinedButton(
                                onPressed: () => _message(
                                  '회원가입 화면을 연결해 주세요.',
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: darkGreen,
                                  minimumSize:
                                      const Size.fromHeight(52),
                                  side: const BorderSide(
                                    color: borderGreen,
                                    width: 1.3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 23),

                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.eco_rounded,
                                    size: 15,
                                    color: green,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    '작은 변화가 만드는 건강한 내일',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: mutedText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: darkGreen,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// Header with a mascot drawn directly in Flutter.
class MascotHeader extends StatelessWidget {
  const MascotHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Container(
        width: double.infinity,
        height: 295,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0F2DE),
              Color(0xFFE0E9C8),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -30,
              bottom: -45,
              child: _hill(190, 115, const Color(0xFFD6E1BD)),
            ),
            Positioned(
              right: -25,
              bottom: -60,
              child: _hill(220, 145, const Color(0xFFC8D8AA)),
            ),
            Positioned(
              left: 12,
              top: 22,
              child: _leaf(25, -0.6),
            ),
            Positioned(
              left: 42,
              top: 120,
              child: _leaf(17, 0.5),
            ),
            Positioned(
              right: 34,
              top: 30,
              child: _leaf(24, 0.8),
            ),
            Positioned(
              right: 24,
              top: 145,
              child: _leaf(17, -0.5),
            ),
            Positioned(
              left: 27,
              top: 33,
              child: Row(
                children: [
                  const Text(
                    'Smoke Out',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Transform.rotate(
                    angle: -0.35,
                    child: const Icon(
                      Icons.eco_rounded,
                      color: green,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 29,
              top: 78,
              child: Text(
                '조금씩 더 건강한 나를 위해',
                style: TextStyle(
                  color: mutedText,
                  fontSize: 14,
                ),
              ),
            ),
            // Display image directly instead of CustomPain
            Positioned(
              right: 25,
              bottom: -10,
              child: Image.asset(
                'assets/cat_mascot.png',
                width: 170,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hill(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(width, height),
        ),
      ),
    );
  }

  Widget _leaf(double size, double angle) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        Icons.eco_rounded,
        size: size,
        color: const Color(0xFFA8BE80),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 17)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height + 7,
        size.width,
        size.height - 17,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Cute sleeping cat with a leaf headband.
