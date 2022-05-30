import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kabyarphatyinhlu/Methods/popup_player.dart';
import 'package:kabyarphatyinhlu/Models/music.dart';
import 'package:kabyarphatyinhlu/Screens/poet_screen.dart';
import 'package:kabyarphatyinhlu/Screens/search_screen.dart';
import 'package:kabyarphatyinhlu/Widgets/favorite_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poem_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poet_list.dart';
import 'package:kabyarphatyinhlu/providers/favorite_provider.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';

import 'Methods/app_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init('favorite');
  runApp(const ProviderScope(child: MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _removeSplashScreen();
  }

  // after 3 seconds, remove the splash screen`
  Future<void> _removeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyHomePage(
              title: 'Flutter',
            ),
        // '/poet': (context) => const PoetScreen(),
        PoetScreen.routeName: (context) => const PoetScreen(),

        '/search': (context) => const SearchScreen(),
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

  @override
  void initState() {
    super.initState();
    ref.read(playlistProvider);
    ref.read(audioPlayerProvider);
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

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final playlist = ref.watch(playlistProvider);
    final audioPlayer = ref.watch(audioPlayerProvider);
    final favoriteList = ref.watch(favoriteProvider);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Future.delayed(Duration.zero, () {
      List<Music> musics = [
        Music(
          id: 1,
          title: "ကဗျာဆရာနှင့် ပတ်သက်ဖူးသော",
          artist: "ဆောင်းဦးသွင်",
          cover: "src/images/ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.png",
          path: "ကဗျာဆရာနှင့်ပတ်သက်ဖူးသော.mp3",
          poet_id: 1,
        ),
        Music(
          id: 2,
          title: "နှုတ်မဆက်ခဲ့ရသူလေးသို့",
          artist: "မိုးရဲ",
          cover: "src/images/နှုတ်မဆက်ခဲ့ရသူလေးသို့.png",
          path: "နှုတ်မဆက်ခဲ့ရသူလေးသို့.mp3",
          poet_id: 2,
        ),
        Music(
          id: 3,
          title: "ကျန်ရစ်ခဲ့တော့မြိုင်",
          artist: "ရဲဘော်စည်သူ",
          path: "ကျန်ရစ်ခဲ့တော့မြိုင်.mp3",
          cover: "src/images/ကျန်ရစ်ခဲ့တော့မြိုင်.png",
          poet_id: 3,
        ),
        Music(
          id: 4,
          title: "ပန်းကလေး",
          artist: "မောင်သိန်းဇော်",
          path: "ပန်းကလေး.mp3",
          cover: "src/images/ပန်းကလေး.png",
          poet_id: 4,
        ),
        Music(
          id: 5,
          title: "ကျေးဇူးတော်လမ်း",
          artist: "စိုင်းဝင်းမြင့်",
          path: "ကျေးဇူးတော်လမ်း.mp3",
          cover: "src/images/ကျေးဇူးတော်လမ်း.png",
          poet_id: 5,
        ),
        Music(
          id: 6,
          title: "ငါချစ်ရင်ပိုပိုချစ်",
          artist: "စိုင်းဝင်းမြင့်",
          path: "ငါချစ်ရင်ပိုပိုချစ်.mp3",
          cover: "src/images/ငါချစ်ရင်ပိုပိုချစ်.png",
          poet_id: 5,
        ),
        Music(
          id: 7,
          title: "မိသားစု",
          artist: "စိုင်းဝင်းမြင့်",
          path: "မိသားစု.mp3",
          cover: "src/images/မိသားစု.png",
          poet_id: 5,
        ),
        Music(
          id: 8,
          title: "အရေးအသားတစ်ခု",
          artist: "စိုင်းဝင်းမြင့်",
          path: "အရေးအသားတစ်ခု.mp3",
          cover: "src/images/အရေးအသားတစ်ခု.png",
          poet_id: 5,
        ),
        Music(
          id: 9,
          title: "သေနေတဲ့အပင်ကိုရှင်အောင်စိုက်တယ်",
          artist: "စိုင်းဝင်းမြင့်",
          path: "သေနေတဲ့အပင်.mp3",
          cover: "src/images/သေနေတဲ့အပင်.png",
          poet_id: 5,
        ),
        Music(
          id: 10,
          title: "စိတ်အတွင်းသားထဲက...နှင်းဆီဝါ (သို့မဟုတ်) မမ",
          artist: "ဆစ်ခ်",
          path: "စိတ်အတွင်းသားထဲကမမ.mp3",
          cover: "src/images/စိတ်အတွင်းသားထဲကမမ.png",
          poet_id: 6,
        ),
        Music(
          id: 11,
          title: "မင်းကိုပြောပြချင်ပြီးပြောပြလို့မရတဲ့ကိစ္စတွေ",
          artist: "ဆစ်ခ်",
          path: "မင်းကိုပြောပြ.mp3",
          cover: "src/images/မင်းကိုပြောပြ.png",
          poet_id: 6,
        ),
        Music(
          id: 12,
          title: "ချစ်မေတ္တာဝေအကြောင်း",
          artist: "မြကျေး",
          path: "ချစ်မေတ္တာဝေအကြောင်း.mp3",
          cover: "src/images/ချစ်မေတ္တာဝေအကြောင်း.png",
          poet_id: 7,
        ),
        Music(
          id: 13,
          title: "အနည်းဆုံးအနေနဲ့ကျွန်မကိုသတိရစေချင်တယ်",
          artist: "မြကျေး",
          path: "အနည်းဆုံးအနေနဲ့.mp3",
          cover: "src/images/အနည်းဆုံးအနေနဲ့.png",
          poet_id: 7,
        ),
        Music(
          id: 14,
          title: "ဂျွန်ကပြောတယ်အားလုံးမြစ်ဆီသို့",
          artist: "မောင်သိန်းဇော်",
          path: "ဂျွန်ကပြောတယ်.mp3",
          cover: "src/images/ဂျွန်ကပြောတယ်.png",
          poet_id: 4,
        ),
        Music(
          id: 15,
          title: "သူပုန်ဘဝ",
          artist: "စောဒိုစိုး",
          path: "သူပုန်ဘဝ.mp3",
          cover: "src/images/သူပုန်ဘဝ.png",
          poet_id: 8,
        ),
        Music(
          id: 16,
          title: "လူယုတ်မာကြီးဖြစ်ချင်တယ် အမေ",
          artist: "ရေနွေးအိုး",
          path: "လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.mp3",
          cover: "src/images/လူယုတ်မာကြီးဖြစ်ချင်တယ်အမေ.png",
          poet_id: 9,
        ),
        Music(
          id: 17,
          title: "အနုပညာသူပုန်",
          artist: "ရေနွေးအိုး",
          path: "အနုပညာသူပုန်.mp3",
          cover: "src/images/အနုပညာသူပုန်.png",
          poet_id: 9,
        ),
        Music(
          id: 18,
          title: "ခင်ဖုန်းသက်ဝေဖတ်ဖို့နွေ",
          artist: "သန်းတင့်",
          path: "ခင်ဖုန်းသက်တွေဖတ်ဖို့.mp3",
          cover: "src/images/ခင်ဖုန်းသက်ဝေဖတ်ဖို့.png",
          poet_id: 10,
        ),
        Music(
          id: 19,
          title: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ",
          artist: "သန်းတင့်",
          path: "ခင်ဖုန်းသက်ဝေဂယ်လာရီ.mp3",
          cover: "src/images/ခင်ဖုန်းသက်ဝေဂယ်လာရီ.png",
          poet_id: 10,
        ),
        Music(
          id: 20,
          title: "တကယ်မရှိသောနှစ်များ",
          artist: "အောင်ခင်မြင့်",
          path: "တကယ်မရှိသောနှစ်.mp3",
          cover: "src/images/တကယ်မရှိသောနှစ်များ.png",
          poet_id: 11,
        ),
        Music(
          id: 21,
          title: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်",
          artist: "အောင်ခင်မြင့်",
          path: "ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.mp3",
          cover: "src/images/ရန်ကုန်မှာမိုးရွာနေတယ်အချစ်.png",
          poet_id: 11,
        ),
        Music(
          id: 22,
          title: "ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ",
          artist: "အောင်မူးဝေ",
          path: "ကွန်မြူနစ်ကလေး.mp3",
          cover: "src/images/ကွန်မြူနစ်ကလေးကိုမေ့လိုက်ပါ.png",
          poet_id: 12,
        ),
        Music(
          id: 23,
          title: "မိခါးချို",
          artist: "အောင်မူးဝေ",
          path: "မိခါးချို.mp3",
          cover: "src/images/မိခါးချို.png",
          poet_id: 12,
        ),
        Music(
          id: 24,
          title: "မင်းကိုကိုယ်ချစ်တယ်",
          artist: "ဇေယျာလင်း",
          path: "မင်းကိုကိုယ်ချစ်တယ်.mp3",
          cover: "src/images/မင်းကိုကိုယ်ချစ်တယ်.png",
          poet_id: 13,
        ),
        Music(
          id: 25,
          title: "အမေ့သားစကားတိုးတိုး ပြောလှည့်ပါ",
          artist: "ဇေယျာလင်း",
          path: "အမေ့သားစကား.mp3",
          cover: "src/images/အမေ့သားစကား.png",
          poet_id: 14,
        ),
        Music(
          id: 26,
          title: "ရေပွက်ပမာ",
          artist: "ပါစီယွန်",
          path: "ရေပွက်ပမာ.mp3",
          cover: "src/images/ရေပွက်ပမာ.png",
          poet_id: 15,
        ),
        Music(
          id: 27,
          title: "ဒေလီယာပန်းတွေပွင့်ပြီ",
          artist: "မိုးဃ်းဇော်",
          path: "ဒေလီယာပန်းတွေပွင့်ပြီ.mp3",
          cover: "src/images/ဒေလီယာပန်းတွေပွင့်ပြီ.png",
          poet_id: 16,
        ),
        Music(
          id: 28,
          title: "ကြယ်ပြာလေးနဲ့ထမင်းစားပြီးနောက်",
          artist: "မောင်ချောနွယ်",
          path: "ကြယ်ပြာလေးနဲ့.mp3",
          cover: "src/images/ကြယ်ပြာလေးနဲ့.png",
          poet_id: 17,
        ),
        Music(
          id: 29,
          title: "ကျနော်က ခင်ဗျားကို ချစ်တယ်ပြောတဲ့ အချိန်",
          artist: "မောင်ရေချမ်း",
          path: "ကျနော်ကခင်ဗျားကိုချစ်တယ်.mp3",
          cover: "src/images/ကျနော်ကခင်ဗျားကိုချစ်တယ်.png",
          poet_id: 18,
        ),
        Music(
          id: 30,
          title: "အချစ်ဇာတ်လမ်း",
          artist: "မောင်သားစစ်",
          path: "အချစ်ဇာတ်လမ်း.mp3",
          cover: "src/images/အချစ်ဇာတ်လမ်း.png",
          poet_id: 19,
        ),
        Music(
          id: 31,
          title: "ကျောင်းဖွင့်ချိန်",
          artist: "ရွှေဘုန်းလူ",
          path: "ကျောင်းဖွင့်ချိန်.mp3",
          cover: "src/images/ကျောင်းဖွင့်ချိန်.png",
          poet_id: 20,
        ),
      ];

      // add music to database
      for (var i = 0; i < musics.length; i++) {
        ref.read(playlistProvider.notifier).add(musics[i]);
      }
    });

    return AdvancedDrawer(
      controller: _advancedDrawerController,
      backdropColor: Colors.blue[50],
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
            textColor: Colors.black,
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
                    "ကဗျာဖတ်ရင်းလှူ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {},
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
                  onTap: () {},
                  leading: const Icon(Icons.favorite),
                  title: const Text(
                    'How to',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        child: const Icon(
                          Icons.dark_mode,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ),
                      Switch(
                        value: false,
                        onChanged: (value) {},
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
                    child: const Text(
                      '© 2022 Nwayookabyar. All rights reserved.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
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
                  color: Colors.white,
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
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(Icons.search_rounded, size: 30),
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black,
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
                      PoemList(playlist: playlist, audioPlayer: audioPlayer),
                      PoetList(playlist: playlist, audioPlayer: audioPlayer),
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
