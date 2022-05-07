import 'package:flutter/material.dart';
import 'package:kabyarphatyinhlu/Screens/poet_screen_arguments.dart';

class PoetScreen extends StatefulWidget {
  const PoetScreen({Key? key}) : super(key: key);
  static const routeName = '/extractArguments';

  @override
  State<PoetScreen> createState() => _PoetScreenState();
}

class _PoetScreenState extends State<PoetScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as PoetScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.poet.name),
      ),
      body: Center(
        child: Text(arguments.poet.name),
      ),
    );
  }
}
