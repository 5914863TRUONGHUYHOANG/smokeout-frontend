import 'package:flutter/material.dart';
import '../models/coach_model.dart';
import '../services/api_service.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  final List<CoachMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    if (!ApiService.instance.isLoggedIn) return;
    try {
      final history = await ApiService.instance.getCoachHistory();
      if (mounted) {
        setState(() {
          _messages.addAll(history);
        });
        _scrollToBottom();
      }
    } catch (_) {}
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    if (!ApiService.instance.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AI 코치와 대화하려면 먼저 로그인해주세요.')),
      );
      return;
    }

    _textController.clear();
    setState(() {
      _messages.add(CoachMessage(role: 'user', content: text));
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final reply = await ApiService.instance.sendCoachMessage(text);
      if (mounted) {
        setState(() {
          _messages.add(CoachMessage(role: 'assistant', content: reply));
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(CoachMessage(
            role: 'assistant',
            content: '죄송합니다. 오류가 발생했습니다: ${e.toString().replaceAll('Exception: ', '')}',
          ));
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _scrollToBottom();
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
        title: Row(
          children: const [
            Icon(Icons.support_agent, color: darkGreen),
            SizedBox(width: 8),
            Text(
              'AI 금연 코치',
              style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: green, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.auto_awesome, size: 14, color: darkGreen),
                SizedBox(width: 4),
                Text(
                  'Gemini',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner nhắc nhở
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: lightGreen.withValues(alpha: 0.5),
            child: Row(
              children: const [
                Icon(Icons.info_outline, size: 18, color: darkGreen),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '흡연 욕구가 생길 때 언제든 털어놓아 보세요. 맞춤 운동과 대처법을 조언해 드립니다.',
                    style: TextStyle(fontSize: 11, color: darkGreen),
                  ),
                ),
              ],
            ),
          ),

          // Message list
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat_bubble_outline, size: 48, color: green),
                        SizedBox(height: 12),
                        Text(
                          '지금 어떤 기분이신가요?\n코치에게 메시지를 보내보세요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: darkGreen, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isUser = msg.isUser;
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? darkGreen : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            msg.content,
                            style: TextStyle(
                              color: isUser ? cream : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: darkGreen, strokeWidth: 2),
              ),
            ),

          // Input field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: '코치에게 메시지 보내기...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: cream,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: darkGreen,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: cream, size: 20),
                      onPressed: _sendMessage,
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

