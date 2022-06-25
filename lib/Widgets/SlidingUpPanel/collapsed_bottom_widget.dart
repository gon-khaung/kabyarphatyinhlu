import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kabyarphatyinhlu/Methods/ad_helper.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

class CollapsedBottomWidget extends ConsumerStatefulWidget {
  const CollapsedBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CollapsedBottomWidgetState createState() => _CollapsedBottomWidgetState();
}

class _CollapsedBottomWidgetState extends ConsumerState<CollapsedBottomWidget> {
  // late RewardedAd mRewardedAd;
  bool _isRewardedAdReady = false;
  bool _isUserClick = false;

  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    ref.read(audioPlayerProvider);
    _loadRewardedAd();
  }

  // AD
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
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
        },
        onAdFailedToLoad: (error) {
          print('Failed to load a rewarded ad: ${error.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(audioPlayerProvider);
    final currentSequence = ref.watch(currentSequenceStream).value;

    if (currentSequence?.sequence.isEmpty ?? true) {
      return const SizedBox();
    }
    final currentPoet = currentSequence!.currentSource!.tag as Music;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
                child: Image(
                  image: AssetImage(currentPoet.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  audioPlayer.stop();
                  if (_isRewardedAdReady) {
                    _rewardedAd?.show(
                      onUserEarnedReward: (_, reward) {
                        audioPlayer.seekToPrevious();
                        audioPlayer.play();
                      },
                    );
                  }
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
                    // if (audioPlayer.playing) {
                    //   audioPlayer.pause();
                    // } else {
                    //   audioPlayer.play();
                    // }

                    if (audioPlayer.playing) {
                      audioPlayer.stop();
                    } else {
                      setState(() {
                        _isUserClick = true;
                      });
                      if (_isRewardedAdReady) {
                        _rewardedAd?.show(
                          onUserEarnedReward: (_, reward) {
                            audioPlayer.play();
                            setState(() {
                              _isUserClick = false;
                            });
                          },
                        );
                      }
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
                  audioPlayer.stop();
                  if (_isRewardedAdReady) {
                    _rewardedAd?.show(
                      onUserEarnedReward: (_, reward) {
                        audioPlayer.seekToNext();
                        audioPlayer.play();
                      },
                    );
                  }
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
