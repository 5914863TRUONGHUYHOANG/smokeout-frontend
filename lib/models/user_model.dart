class UserModel {
  final int userId;
  final String nickname;
  final String email;
  final String fitnessLevel;
  final int totalPoints;
  final DateTime? quitStartDate;
  final int dailyCigaretteCount;
  final int packPrice;

  UserModel({
    required this.userId,
    required this.nickname,
    required this.email,
    this.fitnessLevel = 'BEGINNER',
    this.totalPoints = 0,
    this.quitStartDate,
    this.dailyCigaretteCount = 10,
    this.packPrice = 4500,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? json['user_id'] ?? 0,
      nickname: json['nickname'] ?? json['username'] ?? '',
      email: json['email'] ?? '',
      fitnessLevel: json['fitness_level'] ?? json['fitnessLevel'] ?? 'BEGINNER',
      totalPoints: json['total_points'] ?? json['totalPoints'] ?? 0,
      quitStartDate: json['quit_start_date'] != null
          ? DateTime.tryParse(json['quit_start_date'].toString())
          : null,
      dailyCigaretteCount: json['daily_cigarette_count'] ?? json['dailyCigaretteCount'] ?? 10,
      packPrice: json['pack_price'] ?? json['packPrice'] ?? 4500,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'email': email,
      'fitnessLevel': fitnessLevel,
      'totalPoints': totalPoints,
      'quitStartDate': quitStartDate?.toIso8601String(),
      'dailyCigaretteCount': dailyCigaretteCount,
      'packPrice': packPrice,
    };
  }

  UserModel copyWith({
    int? userId,
    String? nickname,
    String? email,
    String? fitnessLevel,
    int? totalPoints,
    DateTime? quitStartDate,
    int? dailyCigaretteCount,
    int? packPrice,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      totalPoints: totalPoints ?? this.totalPoints,
      quitStartDate: quitStartDate ?? this.quitStartDate,
      dailyCigaretteCount: dailyCigaretteCount ?? this.dailyCigaretteCount,
      packPrice: packPrice ?? this.packPrice,
    );
  }
}

