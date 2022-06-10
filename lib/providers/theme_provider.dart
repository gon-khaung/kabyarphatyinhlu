import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode?>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark) {
    _init();
  }

  void _init() {
    final int? themeInt = GetStorage('favorite').read<int>('theme');
    // state = themeInt.playlist.map((m) {
    //   play.add(Music.fromJson(m));
    //   return Music.fromJson(m);
    // }).toList();
    if (themeInt != null) state = ThemeMode.values[themeInt];
  }

  void setTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    GetStorage('favorite').write('theme', state.index);
  }
}
