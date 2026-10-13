class RankingItem {
  final int rank;
  final int userId;
  final String nickname;
  final int totalPoints;

  RankingItem({
    required this.rank,
    required this.userId,
    required this.nickname,
    required this.totalPoints,
  });

  factory RankingItem.fromJson(Map<String, dynamic> json) {
    return RankingItem(
      rank: int.tryParse(json['rank']?.toString() ?? '0') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      nickname: json['nickname']?.toString() ?? 'Unknown',
      totalPoints: int.tryParse(json['total_points']?.toString() ?? '0') ?? 0,
    );
  }
}

