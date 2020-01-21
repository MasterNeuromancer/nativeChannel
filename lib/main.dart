import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('demo.jope/info');

  String _message = "No messages yet...";

  @override
  void initState() {
    _getMessage().then((String message) {
      setState(() {
        _message = message;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Channels Test'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(_message),
          ),
        ],
      ),
    );
  }

  Future<String> _getMessage() async {
    String value;
    try {
      value = await platform.invokeMethod('getMessage');
    } catch (e) {
      print(e);
    }

    return value;
  }
}
