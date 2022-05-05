import 'dart:convert';

import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final int id;
  String title;
  String artist;
  String path;
  String cover;
  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.cover,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      artist,
      path,
      cover,
    ];
  }

  Music copyWith({
    int? id,
    String? title,
    String? artist,
    String? path,
    String? cover,
  }) {
    return Music(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'artist': artist});
    result.addAll({'path': path});
    result.addAll({'cover': cover});

    return result;
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      path: map['path'] ?? '',
      cover: map['cover'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) => Music.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Music(id: $id, title: $title, artist: $artist, path: $path, cover: $cover)';
  }
}
