import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Methods/app_theme.dart';
import 'Widgets/SlidingUpPanel/collapsed_bottom_widget.dart';
import 'Widgets/SlidingUpPanel/panel_bottom_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // double padding = 100;

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
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
        body: const Center(
          child: Text('You have pushed the button this many times:'),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
