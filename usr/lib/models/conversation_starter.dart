class ConversationStarter {
  final String id;
  final String category;
  final String question;
  final String difficulty;

  ConversationStarter({
    required this.id,
    required this.category,
    required this.question,
    required this.difficulty,
  });

  factory ConversationStarter.fromJson(Map<String, dynamic> json) {
    return ConversationStarter(
      id: json['id'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      difficulty: json['difficulty'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'question': question,
      'difficulty': difficulty,
    };
  }
}