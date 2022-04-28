import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PanelBottomWidget extends StatefulWidget {
  const PanelBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PanelBottomWidget> createState() => _PanelBottomWidgetState();
}

class _PanelBottomWidgetState extends State<PanelBottomWidget> {
  late AudioPlayer _audioPlayer;
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
      AudioSource.uri(Uri.parse(
          "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
      // AudioSource.uri(Uri.parse(
      //     "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void toggleMusicStatus() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // swipable panel
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: NetworkImage(
                              "https://static.toiimg.com/thumb/msid-59174294,imgsize-29115,width-800,height-600,resizemode-75/59174294.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child:
                                  const Icon(Icons.shuffle_rounded, size: 30),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Icon(Icons.repeat_rounded, size: 30),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Icon(Icons.favorite_outline_rounded,
                                  size: 30),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Icon(Icons.library_music_rounded,
                                  size: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var current = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // NOTE: double to int
                                  "${current.inMinutes} : ${current.inSeconds % 60}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${_audioPlayer.duration!.inMinutes} : ${_audioPlayer.duration!.inSeconds % 60}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),

                  // Progress bar of the song with seek bar
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Slider(
                              value: snapshot.data?.inSeconds.toDouble() ?? 0,
                              onChanged: (value) {
                                _audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              },
                              onChangeEnd: (value) {
                                _audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              },
                              min: 0,
                              max:
                                  _audioPlayer.duration?.inSeconds.toDouble() ??
                                      1,
                            );
                          }
                          return Container();
                        },
                      )),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child:
                            const Icon(Icons.skip_previous_rounded, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  // NOTE: Play and Pause button
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(45 / 360),
                    child: Material(
                      color: Colors.red[500],
                      shape: ShapeBorder.lerp(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        0.5,
                      ),
                      child: StreamBuilder<PlayerState>(
                        stream: _audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          return InkWell(
                            onTap: () {
                              if (playerState!.playing) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play();
                              }
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(-45 / 360),
                                child: Icon(
                                  playerState?.playing == true
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const Icon(Icons.skip_next_rounded, size: 40),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
