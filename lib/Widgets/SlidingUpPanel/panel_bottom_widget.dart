import 'package:flutter/material.dart';

class PanelBottomWidget extends StatelessWidget {
  const PanelBottomWidget({
    Key? key,
  }) : super(key: key);

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
            Column(
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
                            child: const Icon(Icons.shuffle_rounded, size: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "1:22",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "2:20",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                      child: InkWell(
                        onTap: () {},
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
