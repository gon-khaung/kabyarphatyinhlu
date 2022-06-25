import 'dart:io';

class AdHelper {
  static String get bannerUnitId {
    // if (Platform.isAndroid) {
    return "ca-app-pub-3940256099942544/6300978111";
    // } else if (Platform.isIOS) {
    //   return "ca-app-pub-3940256099942544/2934735716";
    // } else {
    //   throw UnsupportedError('Unsupported platform');
    // }
  }

  static String get appOpenUnitId {
    return "ca-app-pub-3940256099942544/3419835294";
  }

  static String get rewardUnitId {
    return "ca-app-pub-3940256099942544/5224354917";
  }
}
