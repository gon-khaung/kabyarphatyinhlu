import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kabyarphatyinhlu/Methods/ad_helper.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';
import 'package:kabyarphatyinhlu/providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _textFromFieldController = TextEditingController();

  // late RewardedAd mRewardedAd;
  bool _isRewardedAdReady = false;
  bool _isUserClick = false;

  RewardedAd? _rewardedAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFromFieldController.addListener(() {
      final keyword = _textFromFieldController.text;
      if (keyword.isNotEmpty) {
        ref.read(keywordProvider.notifier).state = keyword;
      } else {
        ref.read(keywordProvider.notifier).state = null;
      }
    });

    _loadRewardedAd();
  }

  // AD
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        _rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          setState(() {
            _isRewardedAdReady = false;
          });
          _loadRewardedAd();
        });
        setState(() {
          _isRewardedAdReady = true;
        });
      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        setState(() {
          _isRewardedAdReady = false;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                controller: _textFromFieldController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  // hintStyle: TextStyle(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.normal,
                  //   color: Colors.black,
                  // ),
                  constraints: BoxConstraints(),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Material(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: InkWell(
                onTap: () {
                  // go to search search screen route
                  // Navigator.pushNamed(context, '/search');
                },
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        // color: Colors.blue[50],
        child: Consumer(
          builder: (context, ref, child) {
            final searchedPlaylist = ref.watch(searchedResult);
            final playlist = ref.watch(playlistProvider);
            final audioPlayer = ref.watch(audioPlayerProvider);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
              child: Consumer(
                builder: (context, ref, child) {
                  final currentIndex = ref.watch(currentMusicIndex).value ?? 0;
                  final currentSequence =
                      ref.watch(currentSequenceStream).value;

                  if (currentSequence?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }

                  final currentPoem =
                      currentSequence!.currentSource!.tag as Music;

                  if (searchedPlaylist == null) {
                    return Center(
                      child: Text(
                        'No result found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }

                  if (searchedPlaylist.isEmpty) {
                    return Center(
                      child: Text(
                        'No result found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: searchedPlaylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (searchedPlaylist[index] == null) {
                        return Container();
                      }
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // currentPoem != searchedPlaylist[index]!.id
                            //     ? audioPlayer.seek(Duration.zero, index: index)
                            //     : null;

                            if (searchedPlaylist[index] != null) {
                              var currentPlaying = searchedPlaylist[index]!;
                              final getIndexOfMusic = playlist.asData!.value
                                  .indexOf(currentPlaying);
                              currentPoem.id != currentPlaying.id
                                  ? audioPlayer.seek(Duration.zero,
                                      index: getIndexOfMusic)
                                  : null;
                            }
                            // audioPlayer.play();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  currentPoem.id == searchedPlaylist[index]!.id
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: AssetImage(
                                          searchedPlaylist[index]!.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchedPlaylist[index]!.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        searchedPlaylist[index]!.artist,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        maxLines: 1,
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
                                      var currentPlaying =
                                          searchedPlaylist[index]!;
                                      final getIndexOfMusic = playlist
                                          .asData!.value
                                          .indexOf(currentPlaying);
                                      audioPlayer.seek(
                                        Duration.zero,
                                        index: getIndexOfMusic,
                                      );

                                      // if (audioPlayer.playing) {
                                      //   audioPlayer.stop();
                                      // } else {
                                      //   audioPlayer.play();
                                      // }

                                      if (audioPlayer.playing) {
                                        if (getIndexOfMusic == index) {
                                          audioPlayer.stop();
                                        } else if (_isRewardedAdReady) {
                                          _rewardedAd?.show(
                                            onUserEarnedReward: (_, reward) {
                                              audioPlayer.play();
                                            },
                                          );
                                        }
                                      } else {
                                        if (_isRewardedAdReady) {
                                          _rewardedAd?.show(
                                            onUserEarnedReward: (_, reward) {
                                              audioPlayer.play();
                                            },
                                          );
                                        }
                                      }
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final playerState =
                                              ref.watch(audioPlayerState).value;

                                          var currentPlaying =
                                              searchedPlaylist[index]!;
                                          final getIndexOfMusic = playlist
                                              .asData!.value
                                              .indexOf(currentPlaying);
                                          return Icon(
                                            playerState != null
                                                ? currentIndex ==
                                                            getIndexOfMusic &&
                                                        playerState.playing
                                                    ? Icons.pause_rounded
                                                    : Icons.play_arrow_rounded
                                                : Icons.play_arrow_rounded,
                                            size: 27,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
