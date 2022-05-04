import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lanpyathu/Models/music.dart';

final playlistProvider = Provider(
  (ref) => [
    Music(
      id: 1,
      title: "Ghost",
      artist: "Justin B",
      path: "ghost.mp3",
      isPlaying: false,
    ),
    Music(
      id: 2,
      title: "Let Me Down Slowly",
      artist: "Alec Benjamin",
      path: "Alec Benjamin - Let Me Down Slowly.mp3",
      isPlaying: false,
    ),
  ],
);

final audioPlayerProvider = Provider.autoDispose<AudioPlayer>((ref) {
  final playlist = ref.watch(playlistProvider);
  final audioPlayer = AudioPlayer();
  audioPlayer
      .setAudioSource(ConcatenatingAudioSource(children: [
    for (var music in playlist)
      AudioSource.uri(Uri.parse('asset:///src/${music.path}')),
  ]))
      .catchError((error) {
    // catch load errors: 404, invalid url ...
    print("An error occured $error");
  });
  return audioPlayer;
});

final audioPlayerState = StreamProvider.autoDispose<PlayerState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  final playerState = audioPlayer.playerStateStream;

  return playerState;
});
