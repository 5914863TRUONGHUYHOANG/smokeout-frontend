class CoachMessage {
  final String role; // 'user' | 'assistant'
  final String content;
  final DateTime? createdAt;

  CoachMessage({
    required this.role,
    required this.content,
    this.createdAt,
  });

  bool get isUser => role == 'user';

  factory CoachMessage.fromJson(Map<String, dynamic> json) {
    return CoachMessage(
      role: json['role'] ?? 'assistant',
      content: json['content'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
    );
  }
}

