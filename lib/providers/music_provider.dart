import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/Models/poet.dart';

final playlistProvider = Provider(
  (ref) => [
    Music(
      id: 1,
      title: "Ghost",
      artist: "Justin B",
      path: "ghost.mp3",
      cover: "src/images/Justice_Explicit.webp",
      poet_id: 1,
      poet: Poet(
          id: 1,
          name: "Justin B",
          cover: "src/images/Justice_Explicit.webp",
          description: "Justin B"),
    ),
    Music(
      id: 2,
      title: "Let Me Down Slowly",
      artist: "Alec Benjamin",
      path: "Alec Benjamin - Let Me Down Slowly.mp3",
      cover: "src/images/Justice_Explicit.webp",
      poet_id: 2,
      poet: Poet(
          id: 1,
          name: "Justin B",
          cover: "src/images/Justice_Explicit.webp",
          description: "Justin B"),
    ),
    Music(
      id: 3,
      title: "Let Me Down Slowly",
      artist: "Alec Benjamin",
      path: "Alec Benjamin - Let Me Down Slowly.mp3",
      cover: "src/images/Justice_Explicit.webp",
      poet_id: 1,
      poet: Poet(
          id: 1,
          name: "Justin B",
          cover: "src/images/Justice_Explicit.webp",
          description: "Justin B"),
    ),
  ],
);

final audioPlayerProvider = Provider.autoDispose<AudioPlayer>((ref) {
  final playlist = ref.watch(playlistProvider);
  final audioPlayer = AudioPlayer();
  audioPlayer
      .setAudioSource(
    ConcatenatingAudioSource(children: [
      for (var music in playlist)
        AudioSource.uri(
          Uri.parse('asset:///src/poems/${music.path}'),
          tag: Music(
            id: music.id,
            title: music.title,
            artist: music.artist,
            path: music.path,
            cover: music.cover,
            poet_id: music.poet_id,
            poet: music.poet,
          ),
        ),
    ]),
  )
      .catchError((error) {
    // catch load errors: 404, invalid url ...
    print("An error occured $error");
  });
  // default loop mode to all

  return audioPlayer;
});

final audioPlayerState = StreamProvider.autoDispose<PlayerState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  final playerState = audioPlayer.playerStateStream;

  return playerState;
});

final currentPositionStream = StreamProvider.autoDispose<Duration>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.positionStream;
});

final loopStream = StreamProvider.autoDispose<LoopMode>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.loopModeStream;
});

final currentMusicIndex = StreamProvider.autoDispose<int?>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.currentIndexStream;
});

final currentSequenceStream = StreamProvider.autoDispose((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return audioPlayer.sequenceStateStream;
});
