import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TIG169"),
          centerTitle: true,
        ),
        body: _ListView(),
      ),
    );
  }
}

class _ListView extends StatefulWidget {
  @override
  __ListViewState createState() => __ListViewState();
}

class __ListViewState extends State<_ListView> {
  bool _isSet = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          secondary: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              print("APA");
            },
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: _isSet,
          onChanged: (bool newVal) {
            setState(
              () {
                _isSet = newVal;
              },
            );
          },
          title: Text("apa1"),
        ),
        CheckboxListTile(
          value: false,
          onChanged: null,
          title: Text("apa2"),
        ),
        CheckboxListTile(
          value: false,
          onChanged: null,
          title: Text("apa3"),
        ),
      ],
    );
  }
}
