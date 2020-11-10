import 'package:flutter/material.dart';
import 'package:todo_list/secondPage.dart';

void main() {
  runApp(Home());
}

//TODO Fråga, är det konvention/ ok att ha kvar dessa globalerna?
//Rensa bort globala variabler
List dbArr = ["122", "2222", "3222", "apan", "sa", "inget", "112"];
List boolArray = new List();

class Home extends StatefulWidget {
  //user input från secondPage. tas in via Homes konstruktor
  final String userInput;

  Home({Key key, this.userInput}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Lägger till användare i dbArr beroende på de kriterier under ifrån secondPage.
  //dbArr ska bytas ut mot db-integration när det SKA GOERASSSSSS då det är utifrån den listviewbuilder skapar första vyn
  void addUserInputTodbArr(widget) {
    if (widget.userInput != null && widget.userInput.isNotEmpty) {
      //print("row 139:  " + widget.userInput);
      dbArr.add(widget.userInput);
      boolArray.add(false);
    } else if (widget.userInput == null) {
      //print("NULL row 142");
    }
  }

  @override
  Widget build(BuildContext context) {
    //BUGG körs var gång sidan byggs upp. ska bara köras när användaren lägger till
    //flytta till listview. För att göra det:
    //flytta metoden och vart man tar emot userInput ifrån secondPage till konstruktorn i MyCustomListView
    addUserInputTodbArr(widget);
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

//"all", "done", "undone" ska vara filter
class MoreButton extends StatefulWidget {
  @override
  _MoreButtonState createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  //Input == false eller true beroende på vad man vill sortera
  List addToFilterIf(input) {
    List filteredArr = [];
    filteredArr.clear();

    for (var i = 0; i < boolArray.length; i++) {
      if (boolArray[i] == input && dbArr.isNotEmpty) {
        filteredArr.add(dbArr[i]);
      } else {
        //print(input.toString() + " i addToFilterIf: ");
      }
    }
    return filteredArr;
  }

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
              setListViewArray(dbArr);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("done"),
            //true
            onTap: () {
              List filteredArr = addToFilterIf(true);

              setListViewArray(filteredArr);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text("undone"),
            //false
            onTap: () {
              List filteredArr = addToFilterIf(false);

              setListViewArray(filteredArr);
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

//TODO Fråga samma som ovan eller hur arbeta bort denna globalen? definiera i home och nå via konstruktor?
List defaultArr = dbArr;

void setListViewArray(inputArr) {
  if (inputArr == null) {
    print("NULL ROW 193");
  } else if (inputArr.length > 0) {
    defaultArr = inputArr;
    //return inputArr;
  }
}

List getListViewArray() {
  return defaultArr;
}

//TODO Här ska listan uppdateras med setState någonstans, WHYYYY GÖR DET INTE DET
class MyCustomListview extends StatefulWidget {
  @override
  _MyCustomListviewState createState() => _MyCustomListviewState();
}

class _MyCustomListviewState extends State<MyCustomListview> {
  Text _title;

  Text checkForNullAndAssignArray(index, defaultArr) {
    var _title;
    //kolla efter NULL-värde innan itembuilder skapar den till listview.
    if (defaultArr[index] == null) {
      //print("NULL ROW 233, Main.dart");
    } else if (defaultArr[index].isEmpty) {
      //print("EMPTY ROW 235");
    } else if (defaultArr[index] != null && defaultArr[index].isNotEmpty) {
      //print("row 237: " + dbArr[index].toString());
      _title = Text(defaultArr[index]);
    }
    return _title;
  }

  void lineThroughIfFalse(index, _title, defaultArr) {
    //Stryker över text om index är true(icehckad). boolArray är en boolsk array indexerad utefter dbArr.
    if (boolArray[index] == true) {
      _title = Text(defaultArr[index],
          style: TextStyle(decoration: TextDecoration.lineThrough));
    }
  }

  void createBoolArray() {
    //skapa unikt bool-värde för varje index i dbArr
    //representerar om den är iklickad eller inte
    for (var i = 0; i < dbArr.length; i++) {
      boolArray.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    createBoolArray();

    defaultArr = getListViewArray();

    return ListView.builder(
      itemCount: defaultArr.length,
      itemBuilder: (context, index) {
        _title = checkForNullAndAssignArray(index, defaultArr);

        lineThroughIfFalse(index, _title, defaultArr);

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
                  defaultArr.removeAt(defaultArr.indexOf(defaultArr[index]));
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
