import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HowTo extends StatefulWidget {
  const HowTo({Key? key}) : super(key: key);

  @override
  State<HowTo> createState() => _HowToState();
}

class _HowToState extends State<HowTo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            child: Text(
          "Comming soon...",
          style: Theme.of(context).textTheme.headline5,
        )),
      ),
    );
  }
}
