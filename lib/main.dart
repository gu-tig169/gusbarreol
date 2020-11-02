import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TIG169"),
          centerTitle: true,
          actions: [
            MoreButton(),
          ],
        ),
        body: _ListView(),
      ),
    );
  }
}

class MoreButton extends StatefulWidget {
  @override
  _MoreButtonState createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  @override
  Widget build(BuildContext context) {
    Icon _icon = Icon(Icons.more_vert);
    return PopupMenuButton(
      icon: _icon,
      //onSelected: , kommer ha en navigator
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("apa"),
        ),
      ],
    );

    // Icon _icon = Icon(Icons.more_vert);
    // return IconButton(
    //   icon: _icon,
    //   onPressed: () {
    //     setState(
    //       () {
    //         _icon = Icon(Icons.more_horiz);
    //         print("apasdasss");
    //       },
    //     );
    //   },
    // );
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
