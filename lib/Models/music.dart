import 'package:equatable/equatable.dart';

import 'package:kabyarphatyinhlu/Models/poet.dart';

class Music extends Equatable {
  final int id;
  String title;
  String artist;
  String path;
  String cover;
  int poet_id;
  Poet? poet;
  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.cover,
    required this.poet_id,
    this.poet,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      artist,
      path,
      cover,
      poet_id,
    ];
  }

  Music copyWith({
    int? id,
    String? title,
    String? artist,
    String? path,
    String? cover,
    int? poet_id,
    Poet? poet,
  }) {
    return Music(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      cover: cover ?? this.cover,
      poet_id: poet_id ?? this.poet_id,
      poet: poet ?? this.poet,
    );
  }

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   result.addAll({'id': id});
  //   result.addAll({'title': title});
  //   result.addAll({'artist': artist});
  //   result.addAll({'path': path});
  //   result.addAll({'cover': cover});
  //   result.addAll({'poet_id': poet_id});
  //   // result.addAll({'poet': poet.toMap()});

  //   return result;
  // }

  // factory Music.fromMap(Map<String, dynamic> map) {
  //   return Music(
  //     id: map['id']?.toInt() ?? 0,
  //     title: map['title'] ?? '',
  //     artist: map['artist'] ?? '',
  //     path: map['path'] ?? '',
  //     cover: map['cover'] ?? '',
  //     poet_id: map['poet_id']?.toInt() ?? 0,
  //     poet: Poet.fromMap(map['poet']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Music.fromJson(String source) => Music.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Music(id: $id, title: $title, artist: $artist, path: $path, cover: $cover, poet_id: $poet_id, poet: $poet)';
  }
}
