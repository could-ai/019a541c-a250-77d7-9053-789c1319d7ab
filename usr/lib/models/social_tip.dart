import 'package:flutter/material.dart';

class SocialTip {
  final String id;
  final String title;
  final String description;
  final String category;
  final IconData icon;

  SocialTip({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
  });

  factory SocialTip.fromJson(Map<String, dynamic> json) {
    return SocialTip(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'iconCodePoint': icon.codePoint,
    };
  }
}