import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabyarphatyinhlu/Models/poet.dart';

final poetList = Provider(
  (ref) => [
    Poet(
      id: 1,
      name: "ဆောင်ဦးသွင်",
      cover: "src/images/Justice_Explicit.webp",
      description: "This is Aung Aung",
    ),
    Poet(
      id: 2,
      name: "မိုးရဲ",
      cover: "src/images/Justice_Explicit.webp",
      description:
          "This is Maung Maung This is Maung Maung This is Maung Maung This is Maung Maung",
    ),
  ],
);

// final poetProvider = Provider<List<Poet>>((ref) {
//   final poets = ref.watch(poetList);

//   return poets;
// });
