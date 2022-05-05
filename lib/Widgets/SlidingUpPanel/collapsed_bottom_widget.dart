import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanpyathu/Widgets/page_manager.dart';
import 'package:lanpyathu/providers/music_provider.dart';

class CollapsedBottomWidget extends ConsumerStatefulWidget {
  const CollapsedBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CollapsedBottomWidgetState createState() => _CollapsedBottomWidgetState();
}

class _CollapsedBottomWidgetState extends ConsumerState<CollapsedBottomWidget> {
  late PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
    ref.read(audioPlayerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(audioPlayerProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const Image(
                  image: AssetImage("src/Justice_Explicit.webp"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  audioPlayer.seekToPrevious();
                },
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(Icons.skip_previous_rounded, size: 40),
                ),
              ),
            ),

            // NOTE: Play and Pause button
            RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Material(
                color: Colors.red[600],
                shape: ShapeBorder.lerp(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  0.5,
                ),
                child: InkWell(
                  onTap: () {
                    if (audioPlayer.playing) {
                      audioPlayer.pause();
                    } else {
                      audioPlayer.play();
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-45 / 360),
                      child: Consumer(builder: (context, ref, child) {
                        final playerState = ref.watch(audioPlayerState).value;
                        return Icon(
                          playerState != null
                              ? playerState.playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 40,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  audioPlayer.seekToNext();
                },
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
    );
  }
}
