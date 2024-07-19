import 'dart:convert';

class Collection {
  final int? id;
  final String? name;
  final String? img;
  final bool? active;

  Collection(
      { this.id,
        this.name,
        this.img,
        this.active
      });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "img": img,
      "active": active,
    };
  }

  String toMap() => json.encode(toJson());
}