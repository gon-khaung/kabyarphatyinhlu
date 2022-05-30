import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';
import 'package:kabyarphatyinhlu/providers/poet_provider.dart';

final keywordProvider = StateProvider<String?>((ref) => null);

final searchedResult =
    StateNotifierProvider<SearchedResultNotifier, List<Music?>?>(
        (ref) => SearchedResultNotifier(ref));

class SearchedResultNotifier extends StateNotifier<List<Music?>?> {
  final Ref ref;

  SearchedResultNotifier(this.ref) : super(null) {
    final keyword = ref.watch(keywordProvider);
    final playlist = ref.watch(playlistProvider);
    final poets = ref.watch(poetList);

    state = playlist.asData!.value.where((element) {
      if (keyword != null) {
        if (element.title.toLowerCase().contains(keyword.toLowerCase()) ||
            element.artist.toLowerCase().contains(keyword)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }).toList();
  }
}
