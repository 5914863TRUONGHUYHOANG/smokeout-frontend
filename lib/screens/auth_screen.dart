import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'test@gmail.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _nicknameController = TextEditingController(text: 'SmokeFreeHero');
  final _cigarettesController = TextEditingController(text: '10');
  final _packPriceController = TextEditingController(text: '4500');

  String _fitnessLevel = 'BEGINNER';
  String? _errorMessage;

  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _cigarettesController.dispose();
    _packPriceController.dispose();
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
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await ApiService.instance.signup(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          nickname: _nicknameController.text.trim(),
          dailyCigaretteCount: int.tryParse(_cigarettesController.text) ?? 10,
          packPrice: int.tryParse(_packPriceController.text) ?? 4500,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: darkGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isLogin ? '로그인' : '회원가입',
          style: const TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Chuyển đổi Đăng nhập / Đăng ký
              Container(
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isLogin ? darkGreen : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              color: isLogin ? cream : darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isLogin ? darkGreen : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              color: !isLogin ? cream : darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade900, fontSize: 13),
                  ),
                ),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: '이메일 (Email)',
                  prefixIcon: const Icon(Icons.email_outlined, color: green),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) =>
                    (val == null || !val.contains('@')) ? '올바른 이메일을 입력해주세요' : null,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 (Password)',
                  prefixIcon: const Icon(Icons.lock_outline, color: green),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) =>
                    (val == null || val.length < 6) ? '비밀번호는 최소 6자 이상입니다' : null,
              ),
              const SizedBox(height: 16),

              // Trường mở rộng khi Đăng ký
              if (!isLogin) ...[
                TextFormField(
                  controller: _nicknameController,
                  decoration: InputDecoration(
                    labelText: '닉네임 (Nickname)',
                    prefixIcon: const Icon(Icons.person_outline, color: green),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (val) =>
                      (val == null || val.trim().isEmpty) ? '닉네임을 입력해주세요' : null,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cigarettesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '하루 흡연량 (개비)',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _packPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '담배 1갑 가격 (원)',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: _fitnessLevel,
                  decoration: InputDecoration(
                    labelText: '운동 수준 (Fitness Level)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'BEGINNER', child: Text('초급 (BEGINNER)')),
                    DropdownMenuItem(value: 'INTERMEDIATE', child: Text('중급 (INTERMEDIATE)')),
                    DropdownMenuItem(value: 'ADVANCED', child: Text('고급 (ADVANCED)')),
                  ],
                  onChanged: (val) => setState(() => _fitnessLevel = val ?? 'BEGINNER'),
                ),
                const SizedBox(height: 24),
              ],

              // Nút submit
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: cream,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: cream, strokeWidth: 2),
                      )
                    : Text(
                        isLogin ? '로그인' : '회원가입 완료',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

