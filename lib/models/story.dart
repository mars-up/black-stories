import 'dart:convert';

class Story {
  final int? id;
  final String collection;
  final String title;
  final String logo;
  final String hint;
  final String image;
  final String solution;
  final String result;
  final bool active;

  Story({
    this.id,
    required this.collection,
    required this.title,
    required this.logo,
    required this.hint,
    required this.image,
    required this.solution,
    required this.result,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection': collection,
      'title': title,
      'logo': logo,
      'hint': hint,
      'image': image,
      'solution': solution,
      'result': result,
      'active': active,
    };
  }

  String toMap() => json.encode(toJson());
}



