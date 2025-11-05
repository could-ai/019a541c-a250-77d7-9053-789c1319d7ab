import 'package:flutter/material.dart';

class Interest {
  final String id;
  final String name;
  final IconData icon;

  Interest({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
    };
  }
}