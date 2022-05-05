// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/services.dart';
// import 'package:lanpyathu/Models/music.dart';

// part 'music_event.dart';
// part 'music_state.dart';

// class MusicBloc extends Bloc<MusicEvent, MusicState> {
//   MusicBloc() : super(MusicLoading()) {
//     on<MusicEvent>((event, emit) {
//       // TODO: implement event handler
//     });

//     on<LoadMusics>(
//       ((event, emit) async {
//         // >> To get paths you need these 2 lines
//         final manifestContent =
//             await rootBundle.loadString('AssetManifest.json');

//         final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//         // >> To get paths you need these 2 lines

//         final String response = await rootBundle.loadString('src/data.json');

//         print(response);
//         // response data into music data model
//         final List<Music> musics =
//             json.decode(response)['poems'].map<Music>((dynamic item) {
//           return Music(
//             id: item['id'],
//             title: item['title'],
//             artist: item['artist'],
//             path: item['path'],
//             isPlaying: false,
//           );
//         }).toList();

//         // final imagePaths = manifestMap.keys
//         //     .where((String key) => key.contains(''))
//         //     .where((String key) => key.contains('.mp3'))
//         //     .toList();
//         // print("Paths: $imagePaths");
//         emit(
//           MusicLoaded(
//             musics: musics,
//           ),
//         );
//         // emit(
//         //   MusicLoaded(
//         //     musics: imagePaths.map((String path) {
//         //       return Music(
//         //         title: path.split('/').last,
//         //         artist: "Justin Bieber",
//         //         path: path,
//         //       );
//         //     }).toList(),
//         //   ),
//         // );
//       }),
//     );

//     on<ChangeActive>(
//       ((event, emit) {
//         // check some music is playing or not and change it to false if it is playing and change it to true if it is not playing
//         final Music music = event.music;
//         final List<Music> musics = event.musics;
//         final bool isPlaying = !music.isPlaying;
//         final Music updatedMusic = music.copyWith(isPlaying: isPlaying);
//         emit(
//           MusicLoaded(
//             musics: musics.map((Music music) {
//               return music.id == updatedMusic.id
//                   ? updatedMusic
//                   : music.copyWith(isPlaying: false);
//             }).toList(),
//           ),
//         );
//       }),
//     );
//   }

//   // void _loadMusics(LoadMusics event, Emitter<MusicState> emit) {
//   //   print("object");
//   //   var imagePaths = [];

//   //   Future _initImages() async {
//   //     // >> To get paths you need these 2 lines
//   //     final manifestContent = await rootBundle.loadString('AssetManifest.json');

//   //     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//   //     // >> To get paths you need these 2 lines

//   //     imagePaths = manifestMap.keys
//   //         .where((String key) => key.contains('src'))
//   //         .where((String key) => key.contains('.mp3'))
//   //         .toList();
//   //     print("Paths: $imagePaths");
//   //   }

//   //   _initImages().then((_) {
//   //     print("Paths: $imagePaths");
//   //     emit(MusicLoading());
//   //     for (var path in imagePaths) {
//   //       final music = Music.fromJson(path);
//   //       // emit(MusicLoaded(musics: [music]));
//   //     }
//   //   });

//   //   var musics = imagePaths
//   //       .map((file) => Music.fromMap(
//   //           const {"title": "aeee", "artist": "ddfd", "path": " file.path"}))
//   //       .toList();
//   //   emit(
//   //     MusicLoaded(
//   //       musics: [
//   //         Music(title: "title", artist: "ff", path: "df"),
//   //         Music(title: "title", artist: "ff", path: "df")
//   //       ],
//   //     ),
//   //   );
//   // }
// }
