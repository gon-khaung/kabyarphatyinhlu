import 'dart:convert';

import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final int id;
  String title;
  String artist;
  String path;
  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
  });

  @override
  List<Object> get props => [id, title, artist, path];

  Music copyWith({
    int? id,
    String? title,
    String? artist,
    String? path,
  }) {
    return Music(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'path': path,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      path: map['path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) => Music.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Music(id: $id, title: $title, artist: $artist, path: $path)';
  }
}
