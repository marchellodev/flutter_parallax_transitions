import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String tag = 'home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String _text = 'Home';

  void _push() {
    Navigator.of(context).pushNamed('other-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_text),
      ),
      body: Center(
        child: Text(_text),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('homePush'),
        onPressed: _push,
        child: const Icon(Icons.add),
      ),
    );
  }
}
