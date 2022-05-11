import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/poet_provider.dart';

class PoetList extends StatelessWidget {
  const PoetList({
    Key? key,
    required this.playlist,
    required this.audioPlayer,
  }) : super(key: key);

  final List<Music> playlist;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final poets = ref.watch(poetList);
        // final currentIndex = ref.watch(currentMusicIndex).value ?? 0;
        // final currentSequence = ref.watch(currentSequenceStream).value;

        // if (currentSequence?.sequence.isEmpty ?? true) {
        //   return const SizedBox();
        // }

        // final currentPoet = currentSequence!.currentSource!.tag as Music;

        // Grid view for poets
        // return Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: GridView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       childAspectRatio: 1.5,
        //       crossAxisSpacing: 10,
        //       mainAxisSpacing: 10,
        //     ),
        //     itemCount: poets.length,
        //     itemBuilder: (context, index) {
        //       final poet = poets[index];

        //       return ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: Material(
        //           color: Colors.transparent,
        //           child: InkWell(
        //             onTap: () {
        //               // go to named route
        //               Navigator.pushNamed(
        //                 context,
        //                 PoetScreen.routeName,
        //                 arguments: PoetScreenArguments(
        //                   poet: poet,
        //                 ),
        //               );
        //             },
        //             splashColor: Colors.white,
        //             child: Stack(
        //               children: [
        //                 // Poet image
        //                 // TODO: Add poet image
        //                 Image.asset(
        //                   poet.cover,
        //                   fit: BoxFit.cover,
        //                   width: double.infinity,
        //                   height: double.infinity,
        //                 ),
        //                 Container(
        //                   width: double.infinity,
        //                   height: double.infinity,
        //                   color: Colors.black.withOpacity(0.6),
        //                 ),
        //                 // Poet name
        //                 Center(
        //                   child: Text(
        //                     poet.name,
        //                     style: GoogleFonts.quicksand(
        //                       fontSize: 16,
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.bold,
        //                       shadows: [
        //                         const Shadow(
        //                           color: Colors.black,
        //                           blurRadius: 10,
        //                           offset: Offset(0, 0),
        //                         ),
        //                       ],
        //                     ),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // );

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  audioPlayer.seek(Duration.zero, index: index);
                  // audioPlayer.play();
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: currentPoet.id == playlist[index].id
                  //       ? Colors.blue[50]
                  //       : Colors.transparent,
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.circular(10),
                  //   ),
                  // ),
                  padding: const EdgeInsets.all(8.0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(poets[index].cover),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              poets[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              poets[index].description,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            audioPlayer.seek(
                              Duration.zero,
                              index: index,
                            );

                            if (audioPlayer.playing) {
                              audioPlayer.stop();
                            } else {
                              audioPlayer.play();
                            }
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Icon(Icons.chevron_right_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 3,
              thickness: 0.3,
              color: Colors.black,
            );
          },
          itemCount: poets.length,
        );
      },
    );
  }
}
