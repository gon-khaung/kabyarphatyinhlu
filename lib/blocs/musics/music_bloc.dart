import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:lanpyathu/Models/music.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicInitial()) {
    on<MusicEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadMusics>(((event, emit) async {
      // >> To get paths you need these 2 lines
      final manifestContent = await rootBundle.loadString('AssetManifest.json');

      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      // >> To get paths you need these 2 lines

      final imagePaths = manifestMap.keys
          .where((String key) => key.contains(''))
          .where((String key) => key.contains('.mp3'))
          .toList();
      print("Paths: $imagePaths");
      emit(MusicLoaded(
          musics: imagePaths.map((String path) {
        return Music(
          title: path.split('/').last,
          artist: '',
          path: path,
        );
      }).toList()));
    }));
  }

  void _loadMusics(LoadMusics event, Emitter<MusicState> emit) {
    print("object");
    var imagePaths = [];

    Future _initImages() async {
      // >> To get paths you need these 2 lines
      final manifestContent = await rootBundle.loadString('AssetManifest.json');

      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      // >> To get paths you need these 2 lines

      imagePaths = manifestMap.keys
          .where((String key) => key.contains('src'))
          .where((String key) => key.contains('.mp3'))
          .toList();
      print("Paths: $imagePaths");
    }

    _initImages().then((_) {
      print("Paths: $imagePaths");
      emit(MusicLoading());
      for (var path in imagePaths) {
        final music = Music.fromJson(path);
        // emit(MusicLoaded(musics: [music]));
      }
    });

    var musics = imagePaths
        .map((file) => Music.fromMap(
            const {"title": "aeee", "artist": "ddfd", "path": " file.path"}))
        .toList();
    emit(
      MusicLoaded(
        musics: [
          Music(title: "title", artist: "ff", path: "df"),
          Music(title: "title", artist: "ff", path: "df")
        ],
      ),
    );
  }
}
