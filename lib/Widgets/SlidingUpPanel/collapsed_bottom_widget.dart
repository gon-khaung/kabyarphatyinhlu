import 'package:flutter/material.dart';

class CollapsedBottomWidget extends StatelessWidget {
  const CollapsedBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
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
                  image: NetworkImage(
                      "https://static.toiimg.com/thumb/msid-59174294,imgsize-29115,width-800,height-600,resizemode-75/59174294.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
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
                  child: const Icon(Icons.skip_previous_rounded, size: 40),
                ),
              ),
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
                child: InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const RotationTransition(
                      turns: AlwaysStoppedAnimation(-45 / 360),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
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
    );
  }
}
