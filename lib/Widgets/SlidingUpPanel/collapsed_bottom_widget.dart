import 'package:flutter/material.dart';
import 'package:lanpyathu/Widgets/page_manager.dart';

class CollapsedBottomWidget extends StatefulWidget {
  const CollapsedBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CollapsedBottomWidget> createState() => _CollapsedBottomWidgetState();
}

class _CollapsedBottomWidgetState extends State<CollapsedBottomWidget> {
  late PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  Widget build(BuildContext context) {
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
                  _pageManager.previous();
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
                child: ValueListenableBuilder<ButtonState>(
                  valueListenable: _pageManager.buttonNotifier,
                  builder: (_, value, __) {
                    return InkWell(
                      onTap: () {
                        if (value == ButtonState.playing) {
                          _pageManager.pause();
                        } else {
                          _pageManager.play();
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
                          child: Icon(
                            value == ButtonState.playing
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _pageManager.next();
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
