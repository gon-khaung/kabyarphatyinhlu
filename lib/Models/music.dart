import 'dart:convert';

import 'package:equatable/equatable.dart';

class Music extends Equatable {
  String title;
  String artist;
  String path;
  Music({
    required this.title,
    required this.artist,
    required this.path,
  });

  @override
  List<Object> get props => [title, artist, path];

  Music copyWith({
    String? title,
    String? artist,
    String? path,
  }) {
    return Music(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'path': path,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      path: map['path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) => Music.fromMap(json.decode(source));

  @override
  String toString() => 'Music(title: $title, artist: $artist, path: $path)';
}
