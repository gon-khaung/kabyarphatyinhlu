// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:lanpyathu/blocs/musics/music_bloc.dart';
// import 'package:lanpyathu/cubit/music_cubit.dart';

// class PageManager {
//   PageManager() {
//     _init();
//   }
//   final progressNotifier = ValueNotifier<ProgressBarState>(
//     ProgressBarState(
//       current: Duration.zero,
//       buffered: Duration.zero,
//       total: Duration.zero,
//     ),
//   );
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

//   final currentMusic = ValueNotifier<int>(0);

//   late AudioPlayer _audioPlayer;

//   void _init() async {
//     _audioPlayer = AudioPlayer();
//     final musicCubit = MusicCubit();
//     final musicBloc = MusicBloc();
//     musicBloc.add(LoadMusics());

//     StreamSubscription musicStream = musicBloc.stream.listen((event) {
//       if (event is LoadMusics) {}
//     });

//     musicStream.onData((data) {
//       var musicsLoaded = data as MusicLoaded;
//       _audioPlayer
//           .setAudioSource(ConcatenatingAudioSource(children: [
//         for (var music in musicsLoaded.musics)
//           AudioSource.uri(Uri.parse('asset:///src/${music.path}')),
//       ]))
//           .catchError((error) {
//         // catch load errors: 404, invalid url ...
//         print("An error occured $error");
//       });
//     });

//     // musicCubit.loadMusics();
//     // var state = musicCubit.stream;
//     // state.listen((value) {
//     //   if (value is LoadedMusic) {
//     //     var musics = value.musics;
//     //     _audioPlayer
//     //         .setAudioSource(ConcatenatingAudioSource(children: [
//     //       for (var music in musics)
//     //         AudioSource.uri(Uri.parse('asset:///src/${music.title}')),
//     //     ]))
//     //         .catchError((error) {
//     //       // catch load errors: 404, invalid url ...
//     //       print("An error occured $error");
//     //     });
//     //   }
//     // });
//   }

//   // current music duration stream to update progress bar
//   Stream<Duration> get currentMusicDurationStream =>
//       _audioPlayer.positionStream;

//   Duration? get duration => _audioPlayer.duration;

//   Stream<int?> get currentMusicIndex => _audioPlayer.currentIndexStream;

//   void play() {
//     _audioPlayer.play();
//     buttonNotifier.value = ButtonState.playing;
//   }

//   void pause() {
//     _audioPlayer.pause();
//     buttonNotifier.value = ButtonState.paused;
//     currentMusic.value = _audioPlayer.currentIndex as int;
//   }

//   void next() {
//     _audioPlayer.seekToNext();
//   }

//   void previous() {
//     _audioPlayer.seekToPrevious();
//   }

//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }
// }

// class ProgressBarState {
//   ProgressBarState({
//     required this.current,
//     required this.buffered,
//     required this.total,
//   });
//   final Duration current;
//   final Duration buffered;
//   final Duration total;
// }

// enum ButtonState { paused, playing, loading }
