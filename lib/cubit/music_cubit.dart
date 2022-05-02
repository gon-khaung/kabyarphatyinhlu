import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:lanpyathu/Models/music.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicInitial());

  Future<void> loadMusics() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains(''))
        .where((String key) => key.contains('.mp3'))
        .toList();
    print("Paths: $imagePaths");
    emit(LoadedMusic(
        musics: imagePaths.map((String path) {
      return Music(
        title: path.split('/').last,
        artist: '',
        path: path,
        id: path.length,
      );
    }).toList()));
  }
}
