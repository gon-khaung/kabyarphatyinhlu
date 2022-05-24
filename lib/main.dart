import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabyarphatyinhlu/Screens/poet_screen.dart';
import 'package:kabyarphatyinhlu/Screens/search_screen.dart';
import 'package:kabyarphatyinhlu/Widgets/favorite_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poem_list.dart';
import 'package:kabyarphatyinhlu/Widgets/poet_list.dart';
import 'package:kabyarphatyinhlu/providers/music_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Methods/app_theme.dart';
import 'Widgets/SlidingUpPanel/collapsed_bottom_widget.dart';
import 'Widgets/SlidingUpPanel/panel_bottom_widget.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

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
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 50.0,
                    bottom: 20.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network("https://via.placeholder.com/150"),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Text(
                    "Kabyar Phat Yin Hlu",
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
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text(
                    'Poets',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.favorite),
                  title: const Text(
                    'Favourites',
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
                      'Version : 1.0.0',
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
                          playlist: playlist, audioPlayer: audioPlayer),
                    ],
                  ),
                ),
              ),
              SlidingUpPanel(
                backdropOpacity: 0.1,
                backdropEnabled: true,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                minHeight: 100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0),
                  ),
                ],
                color: Colors.transparent,
                onPanelOpened: () {
                  setState(() {
                    // padding = 0;
                  });
                },
                onPanelClosed: () {
                  setState(() {
                    // padding = 100;
                  });
                },
                collapsed: const CollapsedBottomWidget(),
                panel: const PanelBottomWidget(),
              ),
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
