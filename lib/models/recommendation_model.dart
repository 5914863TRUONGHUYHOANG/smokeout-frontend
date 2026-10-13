class Exercise {
  final int exerciseId;
  final String title;
  final String category;
  final int durationMinutes;
  final String intensity;
  final String description;
  final String instructions;
  final String? videoUrl;

  Exercise({
    required this.exerciseId,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.intensity,
    required this.description,
    required this.instructions,
    this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: int.tryParse(json['exercise_id']?.toString() ?? json['exerciseId']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      durationMinutes: json['duration_minutes'] ?? json['durationMinutes'] ?? 0,
      intensity: json['intensity'] ?? 'LOW',
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
      videoUrl: json['video_url'] ?? json['videoUrl'],
    );
  }
}

class RecommendationResult {
  final int recommendationId;
  final int symptomLogId;
  final String reason;
  final String source;
  final Exercise exercise;
  final List<dynamic> alternatives;

  RecommendationResult({
    required this.recommendationId,
    required this.symptomLogId,
    required this.reason,
    required this.source,
    required this.exercise,
    required this.alternatives,
  });

  factory RecommendationResult.fromJson(Map<String, dynamic> json) {
    return RecommendationResult(
      recommendationId: int.tryParse(json['recommendationId']?.toString() ?? '0') ?? 0,
      symptomLogId: int.tryParse(json['symptomLogId']?.toString() ?? '0') ?? 0,
      reason: json['reason'] ?? '',
      source: json['source'] ?? 'RULE',
      exercise: Exercise.fromJson(json['exercise'] ?? {}),
      alternatives: json['alternatives'] ?? [],
    );
  }
}

