import 'package:flutter/material.dart';
import '../services/api_service.dart';

const cream = Color(0xFFF8F7E9);
const darkGreen = Color(0xFF3D5D2D);
const green = Color(0xFF587B3D);
const paleGreen = Color(0xFFEAF0D9);
const borderGreen = Color(0xFFD2DDBD);
const mutedText = Color(0xFF77796D);

typedef LoginScreen = AuthScreen;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool isLoading = false;
  bool _hidePassword = true;
  String? _errorMessage;

  final _email = TextEditingController(text: 'test@gmail.com');
  final _password = TextEditingController(text: 'password123');
  final _nickname = TextEditingController(text: 'SmokeFreeHero');
  final _cigarettes = TextEditingController(text: '10');
  final _packPrice = TextEditingController(text: '4500');
  String _fitnessLevel = 'BEGINNER';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _nickname.dispose();
    _cigarettes.dispose();
    _packPrice.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      _errorMessage = null;
    });

    try {
      if (isLogin) {
        await ApiService.instance.login(
          email: _email.text.trim(),
          password: _password.text,
        );
      } else {
        await ApiService.instance.signup(
          email: _email.text.trim(),
          password: _password.text,
          nickname: _nickname.text.trim(),
          dailyCigaretteCount: int.tryParse(_cigarettes.text) ?? 10,
          packPrice: int.tryParse(_packPrice.text) ?? 4500,
          fitnessLevel: _fitnessLevel,
        );
      }
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
      backgroundColor: cream,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    // Cute mascot header with cat_mascot.png
                    MascotHeader(
                      onClose: Navigator.of(context).canPop()
                          ? () => Navigator.of(context).pop()
                          : null,
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        26,
                        20,
                        26,
                        28,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 430,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                isLogin ? '다시 만나요! 🍃' : '환영합니다! 🌱',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: darkGreen,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                isLogin
                                    ? '오늘도 건강한 나를 위해 시작해요.'
                                    : '금연 여정을 함께 시작해 볼까요?',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: mutedText,
                                ),
                              ),
                              const SizedBox(height: 22),

                              if (_errorMessage != null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.red.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error_outline, color: Colors.red, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _errorMessage!,
                                          style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Email Field
                              const FieldLabel('이메일'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: _decoration(
                                  hint: '이메일을 입력하세요',
                                  icon: Icons.mail_outline_rounded,
                                ),
                                validator: (value) {
                                  final text = value?.trim() ?? '';
                                  if (text.isEmpty) {
                                    return '이메일을 입력해 주세요.';
                                  }
                                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                                    return '올바른 이메일을 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),

                              // Password Field
                              const FieldLabel('비밀번호'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _password,
                                obscureText: _hidePassword,
                                textInputAction:
                                    isLogin ? TextInputAction.done : TextInputAction.next,
                                onFieldSubmitted: isLogin ? (_) => _submit() : null,
                                decoration: _decoration(
                                  hint: '비밀번호를 입력하세요',
                                  icon: Icons.lock_outline_rounded,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
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
                                  if (value == null || value.isEmpty) {
                                    return '비밀번호를 입력해 주세요.';
                                  }
                                  if (value.length < 6) {
                                    return '비밀번호는 6자 이상 입력해 주세요.';
                                  }
                                  return null;
                                },
                              ),

                              // Extra fields when Registering
                              if (!isLogin) ...[
                                const SizedBox(height: 18),
                                const FieldLabel('닉네임'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _nickname,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    hint: '닉네임을 입력하세요',
                                    icon: Icons.person_outline_rounded,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return '닉네임을 입력해 주세요.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const FieldLabel('하루 흡연량 (개비)'),
                                          const SizedBox(height: 8),
                                          TextFormField(
                                            controller: _cigarettes,
                                            keyboardType: TextInputType.number,
                                            decoration: _decoration(
                                              hint: '10',
                                              icon: Icons.smoke_free_rounded,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const FieldLabel('담배 1갑 가격 (원)'),
                                          const SizedBox(height: 8),
                                          TextFormField(
                                            controller: _packPrice,
                                            keyboardType: TextInputType.number,
                                            decoration: _decoration(
                                              hint: '4500',
                                              icon: Icons.payments_outlined,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                const FieldLabel('운동 수준 (체력)'),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  initialValue: _fitnessLevel,
                                  decoration: _decoration(
                                    hint: '체력 수준 선택',
                                    icon: Icons.fitness_center_rounded,
                                  ),
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
                                  onChanged: (val) =>
                                      setState(() => _fitnessLevel = val ?? 'BEGINNER'),
                                ),
                              ],

                              if (isLogin) ...[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('비밀번호 재설정 기능은 준비 중입니다.'),
                                        ),
                                      );
                                    },
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
                              ] else ...[
                                const SizedBox(height: 16),
                              ],

                              const SizedBox(height: 8),

                              // Submit Button
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: green,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isLogin ? '로그인' : '회원가입 완료',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              isLogin
                                                  ? Icons.arrow_forward_rounded
                                                  : Icons.check_circle_outline_rounded,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                ),
                              ),

                              const SizedBox(height: 21),

                              // Divider with Switch question
                              Row(
                                children: [
                                  const Expanded(child: Divider(color: borderGreen)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 13),
                                    child: Text(
                                      isLogin ? '아직 회원이 아니신가요?' : '이미 계정이 있으신가요?',
                                      style: const TextStyle(
                                        color: mutedText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: Divider(color: borderGreen)),
                                ],
                              ),

                              const SizedBox(height: 17),

                              // Switch to opposite mode (Login / Register)
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                    _errorMessage = null;
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: darkGreen,
                                  minimumSize: const Size.fromHeight(52),
                                  side: const BorderSide(
                                    color: borderGreen,
                                    width: 1.3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  isLogin ? '회원가입' : '로그인으로 돌아가기',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 23),

                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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

// Header with mascot image cat_mascot.png
class MascotHeader extends StatelessWidget {
  final VoidCallback? onClose;

  const MascotHeader({super.key, this.onClose});

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
              top: 50,
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
              top: 95,
              child: Text(
                '조금씩 더 건강한 나를 위해',
                style: TextStyle(
                  color: mutedText,
                  fontSize: 14,
                ),
              ),
            ),
            // Display cat mascot image
            Positioned(
              right: 25,
              bottom: -10,
              child: Image.asset(
                'assets/cat_mascot.png',
                width: 170,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.pets,
                  size: 80,
                  color: darkGreen,
                ),
              ),
            ),
            // Optional close button if pushed onto navigator
            if (onClose != null)
              Positioned(
                right: 14,
                top: 45,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withValues(alpha: 0.6),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close, size: 18, color: darkGreen),
                    onPressed: onClose,
                  ),
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
      child: const Icon(
        Icons.eco_rounded,
        size: 24,
        color: Color(0xFFA8BE80),
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
