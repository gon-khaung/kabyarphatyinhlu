import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kabyarphatyinhlu/Methods/app_theme.dart';
import 'package:kabyarphatyinhlu/Methods/app_theme_dark.dart';
import 'package:kabyarphatyinhlu/Methods/popup_player.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/Screens/how_to.dart';
import 'package:kabyarphatyinhlu/Screens/poet_screen.dart';
import 'package:kabyarphatyinhlu/Screens/search_screen.dart';
import 'package:kabyarphatyinhlu/Widgets/favorite_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poem_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poet_list.dart';
import 'package:kabyarphatyinhlu/providers/favorite_provider.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';
import 'package:kabyarphatyinhlu/providers/theme_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Methods/app_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init('favorite');

  runApp(const ProviderScope(child: MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    ref.read(themeProvider);
    _removeSplashScreen();
  }

  // after 3 seconds, remove the splash screen`
  Future<void> _removeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeMode,
      theme: appTheme(),
      darkTheme: appThemeDark(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyHomePage(
              title: 'Flutter',
            ),
        // '/poet': (context) => const PoetScreen(),
        PoetScreen.routeName: (context) => const PoetScreen(),

        '/search': (context) => const SearchScreen(),
        '/how_to': (context) => const HowTo(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  // double padding = 100;
  late final _tabController = TabController(length: 3, vsync: this);
  // List<Music> playlist = [];

  @override
  void initState() {
    super.initState();
    ref.read(playlistProvider);
    ref.read(audioPlayerProvider);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _addMusicToList();
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _addMusicToList() {
    List<Music> musics = [
      Music(
        id: 1,
        title: "Who had been related to poet",
        // artist: "ဆောင်းဦးသွင်",
        artist: "Saung Oo Thwin",
        cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
        path: "ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.mp3",
        poet_id: 1,
      ),
      Music(
        id: 2,
        // title: "နှုတ်မဆက်ခဲ့ရသူလေးသို့",
        title: "To the person who didn't say goodbye",
        // artist: "မိုးရဲ",
        artist: "Moe Ye",
        cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
        path: "နှုတ်မဆက်ခဲ့ရသူလေးသို့.mp3",
        poet_id: 2,
      ),
      Music(
        id: 3,
        // title: "ကျန်ရစ်ခဲ့တော့မြိုင်",
        title: "Myain was left behind",
        // artist: "ရဲဘော်စည်သူ",
        artist: "Ye Baw Si Thu",
        path: "ကျန်ရစ်ခဲ့တော့မြိုင်.mp3",
        cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
        poet_id: 3,
      ),
      Music(
        id: 4,
        // title: "ပန်းကလေး",
        title: "Flower",
        // artist: "မောင်သိန်းဇော်",
        artist: "Maung Thein Zaw",
        path: "ပန်းကလေး.mp3",
        cover: "src/images/ပန်းကလေး.png",
        poet_id: 4,
      ),
      Music(
        id: 5,
        // title: "ကျေးဇူးတော်လမ်း",
        title: "The way of grace",
        // artist: "စိုင်းဝင်းမြင့်",
        artist: "Sai Win Myint",
        path: "ကျေးဇူးတော်လမ်း.mp3",
        cover: "src/images/ကျေးဇူးတော်လမ်း.png",
        poet_id: 5,
      ),
      Music(
        id: 6,
        // title: "ငါချစ်ရင်ပိုပိုချစ်",
        title: "If I love, I love more",
        // artist: "စိုင်းဝင်းမြင့်",
        artist: "Sai Win Myint",
        path: "ငါချစ်ရင်ပိုပိုချစ်.mp3",
        cover: "src/images/ငါချစ်ရင်ပိုပိုချစ်.png",
        poet_id: 5,
      ),
      Music(
        id: 7,
        title: "Family",
        // artist: "စိုင်းဝင်းမြင့်",
        artist: "Sai Win Myint",
        path: "မိသားစု.mp3",
        cover: "src/images/မိသားစု.png",
        poet_id: 5,
      ),
      Music(
        id: 8,
        // title: "အရေးအသားတစ်ခု",
        title: "A writing",
        // artist: "စိုင်းဝင်းမြင့်",
        artist: "Sai Win Myint",
        path: "အရေးအသားတစ်ခု.mp3",
        cover: "src/images/အရေးအသားတစ်ခု.png",
        poet_id: 5,
      ),
      Music(
        id: 9,
        // title: "သေနေတဲ့အပင်ကိုရှင်အောင်စိုက်တယ်",
        title: "Plant a dead plant",
        // artist: "စိုင်းဝင်းမြင့်",
        artist: "Sai Win Myint",
        path: "သေနေတဲ့အပင်.mp3",
        cover: "src/images/သေနေတဲ့အပင်.png",
        poet_id: 5,
      ),
      Music(
        id: 10,
        // title: "စိတ်အတွင်းသားထဲက...နှင်းဆီဝါ (သို့မဟုတ်) မမ",
        title: "From the inner heart...rose yellow (or) Ma Ma",
        // artist: "ဆစ်ခ်",
        artist: "Sikh",
        path: "စိတ်အတွင်းသားထဲကမမ.mp3",
        cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
        poet_id: 6,
      ),
      Music(
        id: 11,
        // title: "မင်းကိုပြောပြချင်ပြီးပြောပြလို့မရတဲ့ကိစ္စတွေ",
        title: "Things I want to tell you but can't tell you",
        // artist: "ဆစ်ခ်",
        artist: "Sikh",
        path: "မင်းကိုပြောပြ.mp3",
        cover: "src/images/မင်းကိုပြောပြ.png",
        poet_id: 6,
      ),
      Music(
        id: 12,
        // title: "ချစ်မေတ္တာဝေအကြောင်း",
        title: "About love",
        // artist: "မြကျေး",
        artist: "Mya Kyay",
        path: "ချစ်မေတ္တာဝေအကြောင်း.mp3",
        cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
        poet_id: 7,
      ),
      Music(
        id: 13,
        // title: "အနည်းဆုံးအနေနဲ့ကျွန်မကိုသတိရစေချင်တယ်",
        title: "At least I want to be remembered",
        // artist: "မြကျေး",
        artist: "Mya Kyay",
        path: "အနည်းဆုံးအနေနဲ့.mp3",
        cover: "src/images/အနည်းဆုံးအနေနဲ့.png",
        poet_id: 7,
      ),
      Music(
        id: 14,
        // title: "ဂျွန်ကပြောတယ်အားလုံးမြစ်ဆီသို့",
        title: "John said all to the river",
        // artist: "မောင်သိန်းဇော်",
        artist: "Maung Thein Zaw",
        path: "ဂျွန်ကပြောတယ်.mp3",
        cover: "src/images/ဂျွန်ကပြောတယ်.png",
        poet_id: 4,
      ),
      Music(
        id: 15,
        // title: "သူပုန်ဘဝ",
        title: "Rebel life",
        // artist: "စောဒိုစိုး",
        artist: "Saw Do Soe",
        path: "သူပုန်ဘဝ.mp3",
        cover: "src/images/သူပုန်ဘဝ.png",
        poet_id: 8,
      ),
      Music(
        id: 16,
        // title: "လူယုတ်မာကြီးဖြစ်ချင်တယ် အမေ",
        title: "I want to be a big bastard, mom",
        // artist: "ရေနွေးအိုး",
        artist: "Yay Nway O",
        path: "လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.mp3",
        cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
        poet_id: 9,
      ),
      Music(
        id: 17,
        // title: "အနုပညာသူပုန်",
        title: "Art rebel",
        // artist: "ရေနွေးအိုး",
        artist: "Yay Nway O",
        path: "အနုပညာသူပုန်.mp3",
        cover: "src/images/အနုပညာသူပုန်.png",
        poet_id: 9,
      ),
      Music(
        id: 18,
        // title: "ခင်ဖုန်းသက်ဝေဖတ်ဖို့နွေ",
        title: "Summer for Khin Phone Thet Wai to read",
        // artist: "သန်းတင့်",
        artist: "Than Tint",
        path: "ခင်ဖုန်းသက်တွေဖတ်ဖို့.mp3",
        cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
        poet_id: 10,
      ),
      Music(
        id: 19,
        // title: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ",
        title: "Khin Phone Thet Wai's Gallery",
        // artist: "သန်းတင့်",
        artist: "Than Tint",
        path: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ.mp3",
        cover: "src/images/ခင်ဖုန်းသက်ဝေဂယ်လာရီ.png",
        poet_id: 10,
      ),
      Music(
        id: 20,
        // title: "တကယ်မရှိသောနှစ်များ",
        title: "Years that didn't really exist",
        // artist: "အောင်ခင်မြင့်",
        artist: "Aung Khin Myint",
        path: "တကယ်မရှိသောနှစ်.mp3",
        cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
        poet_id: 11,
      ),
      Music(
        id: 21,
        // title: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်",
        title: "It is raining in Yangon",
        // artist: "အောင်ခင်မြင့်",
        artist: "Aung Khin Myint",
        path: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.mp3",
        cover: "src/images/ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.png",
        poet_id: 11,
      ),
      Music(
        id: 22,
        // title: "ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ",
        title: "Forget the communist",
        // artist: "အောင်မူးဝေ",
        artist: "Aung Muu Wai",
        path: "ကွန်မြူနစ်ကလေး.mp3",
        cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
        poet_id: 12,
      ),
      Music(
        id: 23,
        // title: "မိခါးချို",
        title: "Mi Khar Cho",
        // artist: "အောင်မူးဝေ",
        artist: "Aung Muu Wai",
        path: "မိခါးချို.mp3",
        cover: "src/images/မိခါးချို.png",
        poet_id: 12,
      ),
      Music(
        id: 24,
        // title: "မင်းကိုကိုယ်ချစ်တယ်",
        title: "I love you",
        // artist: "ဇေယျာလင်း",
        artist: "Zayar Lin",
        path: "မင်းကိုကိုယ်ချစ်တယ်.mp3",
        cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
        poet_id: 13,
      ),
      Music(
        id: 25,
        // title: "အမေ့သားစကားတိုးတိုး ပြောလှည့်ပါ",
        title: "Speak quietly my son",
        // artist: "ဇေယျာလင်း",
        artist: "Zayar Lin",
        path: "အမေ့သားစကား.mp3",
        cover: "src/images/အမေ့သားစကား.png",
        poet_id: 14,
      ),
      Music(
        id: 26,
        // title: "ရေပွက်ပမာ",
        title: "Like water bubbles",
        // artist: "ပါစီယွန်",
        artist: "Percyon",
        path: "ရေပွက်ပမာ.mp3",
        cover: "src/images/ရေပွက်ပမာ.png",
        poet_id: 15,
      ),
      Music(
        id: 27,
        // title: "ဒေလီယာပန်းတွေပွင့်ပြီ",
        title: "The dahlias have bloomed",
        // artist: "မိုးဃ်းဇော်",
        artist: "Moe Zaw",
        path: "ဒေလီယာပန်းတွေပွင့်ပြီ.mp3",
        cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
        poet_id: 16,
      ),
      Music(
        id: 28,
        // title: "ကြယ်ပြာလေးနဲ့ထမင်းစားပြီးနောက်",
        title: "After dining with the blue star",
        // artist: "မောင်ချောနွယ်",
        artist: "Maung Chaw Nwe",
        path: "ကြယ်ပြာလေးနဲ့.mp3",
        cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
        poet_id: 17,
      ),
      Music(
        id: 29,
        // title: "ကျနော်က ခင်ဗျားကို ချစ်တယ်ပြောတဲ့ အချိန်",
        title: "When I said I love you",
        // artist: "မောင်ရေချမ်း",
        artist: "Maung Yay Chan",
        path: "ကျနော်ကခင်ဗျားကိုချစ်တယ်.mp3",
        cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
        poet_id: 18,
      ),
      Music(
        id: 30,
        // title: "အချစ်ဇာတ်လမ်း",
        title: "Love story",
        // artist: "မောင်သားစစ်",
        artist: "Maung Thar Sit",
        path: "အချစ်ဇာတ်လမ်း.mp3",
        cover: "src/images/အချစ်ဇာတ်လမ်း.png",
        poet_id: 19,
      ),
      Music(
        id: 31,
        // title: "ကျောင်းဖွင့်ချိန်",
        title: "School opening time",
        // artist: "ရွှေဘုန်းလူ",
        artist: "Shwe Phone Lu",
        path: "ကျောင်းဖွင့်ချိန်.mp3",
        cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
        poet_id: 20,
      ),
    ];

    // add music to database
    for (var i = 0; i < musics.length; i++) {
      ref.read(playlistProvider.notifier).add(musics[i]);
    }
    // ref.read(playlistProvider.notifier).addAll(musics);
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(audioPlayerProvider);
    final favoriteList = ref.watch(favoriteProvider);
    final playlist = ref.watch(playlistProvider);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Future.delayed(Duration.zero, () {});

    return AdvancedDrawer(
      controller: _advancedDrawerController,
      backdropColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).primaryColor
          : Colors.blue[50],
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ListTileTheme(
            textColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            iconColor: Colors.red,
            style: ListTileStyle.drawer,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 100.0,
                  margin: const EdgeInsets.only(
                    top: 50.0,
                    bottom: 20.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "src/images/nwayookabyar-red.jpg",
                    // fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Text(
                    "Donate while you listen",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // go to /home
                    Navigator.pushNamed(context, '/');
                  },
                  leading: const Icon(
                    Icons.home,
                    size: 30,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // ListTile(
                //   onTap: () {},
                //   leading: const Icon(Icons.account_circle_rounded),
                //   title: const Text(
                //     'Poets',
                //     style: TextStyle(
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/how_to');
                  },
                  leading: const Icon(Icons.favorite),
                  title: const Text(
                    'How to ?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            final theme = ref.read(themeProvider.notifier);
                            theme.setTheme();
                          },
                          child: Icon(
                            Theme.of(context).brightness == Brightness.dark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            size: 40,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text(
                      '© 2022 Nwayookabyar. All rights reserved.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _advancedDrawerController.showDrawer();
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(Icons.menu_rounded, size: 30),
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: InkWell(
                    onTap: () {
                      // go to search search screen route
                      Navigator.pushNamed(context, '/search');
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.transparent),
                      child: const Icon(
                        Icons.search_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              // labelColor: Colors.red,
              // unselectedLabelColor: Colors.black,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3.5,
              tabs: const [
                Tab(
                  child: Text(
                    "Poems",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Poets",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Favorites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // extendBodyBehindAppBar: true,

          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
                child: Center(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      const PoemList(),
                      const PoetList(),
                      FavoriteList(
                          playlist: favoriteList, audioPlayer: audioPlayer),
                    ],
                  ),
                ),
              ),
              const PopupPlayer(),
            ],
          )

          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
