import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanpyathu/blocs/musics/music_bloc.dart';
import 'package:lanpyathu/providers/music_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Methods/app_theme.dart';
import 'Widgets/SlidingUpPanel/collapsed_bottom_widget.dart';
import 'Widgets/SlidingUpPanel/panel_bottom_widget.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: BlocProvider(
        create: (context) => MusicBloc()..add(LoadMusics()),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      debugShowCheckedModeBanner: false,
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
                  onTap: () {},
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
        extendBodyBehindAppBar: true,

        body: SlidingUpPanel(
            backdropOpacity: 0.1,
            backdropEnabled: true,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
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
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
                child: Consumer(
                  builder: (context, ref, child) {
                    final currentIndex =
                        ref.watch(currentMusicIndex).value ?? 0;
                    final currentSequence =
                        ref.watch(currentSequenceStream).value;

                    final currentPoet =
                        currentSequence?.currentSource?.tag ?? 0;

                    print("currentIndex: $currentSequence");

                    return ListView.builder(
                      itemCount: playlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              audioPlayer.seek(Duration.zero, index: index);
                              // audioPlayer.play();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: currentPoet == playlist[index].id
                                    ? Colors.blue[50]
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: const Image(
                                          image: AssetImage(
                                              "src/Justice_Explicit.webp")),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playlist[index].title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          playlist[index].artist,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        audioPlayer.seek(
                                          Duration.zero,
                                          index: index,
                                        );

                                        if (audioPlayer.playing) {
                                          audioPlayer.stop();
                                        } else {
                                          audioPlayer.play();
                                        }
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            final playerState = ref
                                                .watch(audioPlayerState)
                                                .value;
                                            return Icon(
                                                playerState != null
                                                    ? currentIndex == index &&
                                                            playerState.playing
                                                        ? Icons.pause_rounded
                                                        : Icons
                                                            .play_arrow_rounded
                                                    : Icons.play_arrow_rounded,
                                                size: 27);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
