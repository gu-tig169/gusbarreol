import 'package:flutter/material.dart';
import 'package:todo_list/secondPage.dart';

void main() {
  runApp(Home());
}

String sorterVar = "all";
var testArr = ["122", "2222", "3222", "322", "322", "322", "322"];
var boolArray = new List();
var filteredDoneArr = new List<String>();
var filteredUndoneArr = new List<String>();

class Home extends StatefulWidget {
  //user input från secondPage. tas in via Homes konstruktor
  final String userInput;

  Home({Key key, this.userInput}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //körs var gång sidan byggs upp. Finns det bättre sätt?
    addUserInputToTestArr(widget);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TIG169 TODO"),
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
class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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

//TODO "all", "done", "undone" ska vara filter
//SKapa en filterfunktion som filtrerar testArr beroende på boolArr?
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
              // //ska visa både true och false
              // sorterVar = "all";
              // print(sorterVar);
              // setState(() {
              //   testArr = testArr;
              // });

              print(boolArray);
              boolArray = boolArray
                  .where((element) => element == true && false)
                  .toList();
              print(boolArray);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("done"),
            onTap: () {
              // sorterVar = "done";
              // print(sorterVar);
              // filteredDoneArr.clear();
              // for (int i = 0; i < testArr.length; i++) {
              //   if (boolArray[i] == true) {
              //     filteredDoneArr.add(testArr[i]);
              //     //print("true testArr " + testArr[i]);
              //   }
              // }
              // setState(() {
              //   testArr = filteredDoneArr;
              // });
              // print(testArr);
              print(boolArray);
              boolArray =
                  boolArray.where((element) => element == true).toList();
              print(boolArray);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("undone"),
            onTap: () {
              // //ska visa false
              // sorterVar = "undone";
              // print(sorterVar);
              // filteredUndoneArr.clear();
              // for (int i = 0; i < testArr.length; i++) {
              //   if (boolArray[i] == false) {
              //     filteredUndoneArr.add(testArr[i]);
              //     //print("false testArr " + testArr[i]);
              //   }
              // }
              // setState(() {
              //   testArr = filteredUndoneArr;
              // });
              // print(testArr);
              print(boolArray);
              boolArray =
                  boolArray.where((element) => element == false).toList();
              print(boolArray);
            },
          ),
        ),
      ],
    );

    //sätta "morebutton" vertikalt vid klick. do if ajwant
    // Icon _icon = Icon(Icons.more_vert); m knm
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

// //bestämmer vilken lista som listview ska visa
// List filter() {
//   if (sorterVar == "done") {
//     //returenra lista med done
//     for (int i = 0; i < testArr.length; i++) {
//       if (boolArray[i] == true) {
//         filteredArr.add(testArr[i]);
//         print("true testArr " + testArr[i]);
//       }
//     }
//     return filteredArr;
//   } else if (sorterVar == "undone") {
//     //returnera lista med undone
//     for (int i = 0; i < testArr.length; i++) {
//       if (boolArray[i] == false) {
//         filteredArr.add(testArr[i]);
//         print("false testArr " + testArr[i]);
//       }
//     }
//     return filteredArr;
//   } else if (sorterVar == "all") {
//     //returnera vanliga listan
//     return testArr;
//   }
// }

// List filter() {
//   filteredArr = testArr.where((boolArray) => true).toList();
//   return filteredArr;
// }

//BUG lägger till ny varje gång koden körs, inte så viktigt.
//Lägger till användare i testArr beroende på de kriterier under ifrån secondPage.
//testArr ska bytas ut mot db-integration när det SKA GOERASSSSSS då det är utifrån den listviewbuilder skapar första vyn
void addUserInputToTestArr(widget) {
  if (widget.userInput != null && widget.userInput.isNotEmpty) {
    //print("row 139:  " + widget.userInput);
    testArr.add(widget.userInput);
  } else if (widget.userInput == null) {
    //print("NULL row 142");
  }
}

class MyCustomListview extends StatefulWidget {
  @override
  _MyCustomListviewState createState() => _MyCustomListviewState();
}

class _MyCustomListviewState extends State<MyCustomListview> {
  Text _title;
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
        //kolla efter NULL-värde innan itembuilder skapar den till listview.
        if (testArr[index] == null) {
          //print("NULL ROW 233, Main.dart");
        } else if (testArr[index].isEmpty) {
          //print("EMPTY ROW 235");
        } else if (testArr[index] != null && testArr[index].isNotEmpty) {
          //print("row 237: " + testArr[index].toString());
          _title = Text(testArr[index]);
        }

        //Stryker över text om index är true(icehckad). boolArray är en boolsk array indexerad utefter testArr.
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
