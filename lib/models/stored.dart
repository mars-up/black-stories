import 'dart:convert';

class Stored {
  int? id;
  int user_id;
  int collection_id;
  int story_id;
  String dateTimeCompleted;

  Stored({
    this.id,
    required this.user_id,
    required this.collection_id,
    required this.story_id,
    required this.dateTimeCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'collection_id': collection_id,
      'story_id': story_id,
      'dateTimeCompleted': dateTimeCompleted,
    };
  }

  factory Stored.fromMap(Map<dynamic, dynamic> map) {
    return Stored(
      id: map['id']?.toInt() ?? 0,
      user_id: map['user_id'] ?? 0,
      collection_id: map['collection_id'] ?? 0,
      story_id: map['story_id'] ?? 0,
      dateTimeCompleted: map['dateTimeCompleted']  ?? '',
    );
  }

  String toMap() => json.encode(toJson());
}
