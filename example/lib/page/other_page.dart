import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  static const String tag = 'other-page';
  const OtherPage({Key? key}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {

  final String _text = 'Other';

  void _push() {
    Navigator.of(context).pushNamed('home-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(_text),
      ),
      body: Center(
        child: Text(_text),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('otherPush'),
        onPressed: _push,
        child: const Icon(Icons.add),
      ),
    );
  }
}
