import 'package:flutter/material.dart';
import 'package:todo_list/secondPage.dart';

//FIXA INLÄMNINGEN n

void main() {
  runApp(Home());
}

var testArr = ["122", "2222", "3222", "322", "322", "322", "322"];
var boolArray = new List();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: MyCustomListview(),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

//preferedsizewidget är till för att kunna bryta ut appbar
class MyCustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("TIG169"),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

//TODO checka i alla i "testArr", done eller undone
//all=markera alla. done=boolArray alla true. undone=boolArray alla false
//vänta på db-integration innan denna
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
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            title: Text("all"),
            onTap: () {
              setState(() {
                //print("all");
                //sätta alla till true?
              });
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("done"),
            onTap: () {
              setState(() {
                print("done");
              });
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("undone"),
            onTap: () {
              setState(() {
                print("undone");
              });
            },
          ),
        ),
      ],
    );

    //sätta "morebutton" vertikalt vid klick
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

//Dynamisk listview på testArr
class MyCustomListview extends StatefulWidget {
  @override
  _MyCustomListviewState createState() => _MyCustomListviewState();
}

class _MyCustomListviewState extends State<MyCustomListview> {
  @override
  Widget build(BuildContext context) {
    //skapa unikt bool-värde för varje index i testArr
    //representerar om den är iklickad eller inte
    for (var i = 0; i < testArr.length; i++) {
      boolArray.add(false);
    }
    return ListView.builder(
      itemCount: testArr.length,
      itemBuilder: (context, index) {
        var _title = Text(testArr[index]);

        //Stryker över text om true
        if (boolArray[index] == true) {
          _title = Text(testArr[index],
              style: TextStyle(decoration: TextDecoration.lineThrough));
        }

        return Card(
          margin: EdgeInsets.all(5.0),
          child: CheckboxListTile(
            value: boolArray[index],
            title: _title,
            //on checkbox-press sätt index till true
            onChanged: (bool newVal) {
              setState(() {
                boolArray[index] = newVal;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            secondary: IconButton(
              icon: Icon(Icons.close),
              //On x-press
              onPressed: () {
                setState(() {
                  testArr.removeAt(testArr.indexOf(testArr[index]));
                });
              },
            ),
          ),
        );
      },
    );
  }
}

// //ej dynamisk lista
// class ListView extends StatefulWidget {
//   @override
//   _ListViewState createState() => _ListViewState();
// }

// class _ListViewState extends State<ListView> {
//   bool _isSet = false;
//   Text _title = Text("apa1");
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         CheckboxListTile(
//           secondary: IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               print("APA");
//             },
//           ),
//           controlAffinity: ListTileControlAffinity.leading,
//           value: _isSet,
//           onChanged: (bool newVal) {
//             setState(
//               () {
//                 _isSet = newVal;
//                 if (_isSet == true) {
//                   _title = Text(
//                     "apa1",
//                     style: TextStyle(decoration: TextDecoration.lineThrough),
//                   );
//                 } else {
//                   _title = Text("apa1");
//                 }
//               },
//             );
//           },
//           title: _title,
//         ),
//         CheckboxListTile(
//           value: false,
//           onChanged: null,
//           title: Text("apa2"),
//         ),
//         CheckboxListTile(
//           value: false,
//           onChanged: null,
//           title: Text("apa3"),
//         ),
//       ],
//     );
//   }
// }
