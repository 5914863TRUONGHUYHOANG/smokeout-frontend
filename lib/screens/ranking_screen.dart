import 'package:flutter/material.dart';
import '../models/ranking_model.dart';
import '../services/api_service.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late Future<List<RankingItem>> _rankingsFuture;

  static const Color cream = Color.fromRGBO(248, 248, 236, 1.0);
  static const Color card = Color.fromRGBO(253, 253, 246, 1.0);
  static const Color darkGreen = Color.fromRGBO(63, 92, 43, 1.0);
  static const Color green = Color.fromRGBO(91, 126, 61, 1.0);
  static const Color lightGreen = Color.fromRGBO(232, 242, 207, 1.0);
  static const Color borderGreen = Color.fromRGBO(210, 220, 190, 1.0);

  @override
  void initState() {
    super.initState();
    _loadRankings();
  }

  void _loadRankings() {
    setState(() {
      _rankingsFuture = ApiService.instance.getRankings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ApiService.instance.currentUser?.userId;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,
        title: const Text(
          '랭킹 (Leaderboard)',
          style: TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: darkGreen),
            onPressed: _loadRankings,
          ),
        ],
      ),
      body: FutureBuilder<List<RankingItem>>(
        future: _rankingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: darkGreen));
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('오류: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loadRankings,
                    style: ElevatedButton.styleFrom(backgroundColor: darkGreen),
                    child: const Text('다시 시도', style: TextStyle(color: cream)),
                  ),
                ],
              ),
            );
          }

          final rankings = snapshot.data ?? [];
          if (rankings.isEmpty) {
            return const Center(
              child: Text(
                '아직 랭킹 데이터가 없습니다.',
                style: TextStyle(color: darkGreen, fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadRankings(),
            color: darkGreen,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: rankings.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = rankings[index];
                final isMe = currentUserId != null && item.userId == currentUserId;

                Color rankBadgeColor;
                IconData? rankIcon;

                if (item.rank == 1) {
                  rankBadgeColor = const Color(0xFFFFD700); // Gold
                  rankIcon = Icons.emoji_events;
                } else if (item.rank == 2) {
                  rankBadgeColor = const Color(0xFFC0C0C0); // Silver
                  rankIcon = Icons.military_tech;
                } else if (item.rank == 3) {
                  rankBadgeColor = const Color(0xFFCD7F32); // Bronze
                  rankIcon = Icons.military_tech;
                } else {
                  rankBadgeColor = lightGreen;
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? lightGreen.withValues(alpha: 0.5) : card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isMe ? darkGreen : borderGreen,
                      width: isMe ? 2.0 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Rank Badge
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: rankBadgeColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: rankIcon != null
                            ? Icon(rankIcon, size: 22, color: Colors.black87)
                            : Text(
                                '${item.rank}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      const SizedBox(width: 14),

                      // Nickname + "나" badge
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.nickname,
                                  style: TextStyle(
                                    fontWeight: isMe ? FontWeight.bold : FontWeight.w600,
                                    fontSize: 16,
                                    color: darkGreen,
                                  ),
                                ),
                                if (isMe) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: darkGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      '나',
                                      style: TextStyle(
                                        color: cream,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              'ID: ${item.userId}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      // Points
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${item.totalPoints} P',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: green,
                            ),
                          ),
                          const Text(
                            '누적 포인트',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

