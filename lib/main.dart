import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:todo_list/secondPage.dart';
import 'package:todo_list/Model/Model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Model(), builder: (context, child) => Home()));
}

//TODO
//1. om listan är tom ska det visas en text som förklarar det. metoden är skriven brööör

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color.fromRGBO(69, 90, 100, 1)),
      ),
      home: Scaffold(
        appBar: _myHomeAppBar(),
        body: Column(
          children: [
            _myDateContainer(),
            Divider(height: 30),
            Expanded(child: MyCustomListview()),
          ],
        ),
        floatingActionButton: _myHomeFloatingActionButton(),
      ),
    );
  }

  Widget _myDateContainer() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    return SizedBox(
      height: 153,
      child: Container(
          color: Colors.grey.shade300,
          width: 1000000,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DigitalClock(
                digitAnimationStyle: Curves.elasticOut,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 50,
                ),
                showSecondsDigit: false,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Idag är det den ${dateParse.day} i ${dateParse.month}, ${dateParse.year} och det här är dina TODOs:",
                  style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
                ),
              ),
            ],
          )),
    );
  }

  Widget _myHomeAppBar() {
    return AppBar(
      title: Text("TODO"),
      centerTitle: true,
      actions: [
        MoreButton(),
      ],
    );
  }

  Widget _myHomeFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        backgroundColor: Color.fromRGBO(69, 90, 100, 1),
        onPressed: () async {
          final userInput = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTaskPage()));
          //pushar på userInput på listan
          Provider.of<Model>(context, listen: false)
              .addUserInputToTodoList(userInput);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Icon _icon = Icon(Icons.more_vert);
    return Consumer<Model>(
      builder: (context, state, child) => PopupMenuButton(
        icon: _icon,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              title: Text("all"),
              onTap: () {
                state.filter("all");
                Navigator.pop(context);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text("done"),
              //true
              onTap: () {
                state.filter("done");
                Navigator.pop(context);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text("undone"),
              //false
              onTap: () {
                state.filter("undone");
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, state, child) => state.syncingLists == false
          ? Scrollbar(
              child: ListView.builder(
                itemCount: state.getTodoList.length,
                itemBuilder: (context, index) {
                  return _myListContainer(index, state);
                },
              ),
            )
          : Center(
              child: SpinKitChasingDots(
                color: Color.fromRGBO(69, 90, 100, 1),
                size: 50.0,
              ),
            ),
    );
  }

  // // Visar tom om listan är tom annars laddhjul
  // Widget checkListIfEmpty(state) {
  //   if (state.syncingLists == false) {
  //     return Scrollbar(
  //       child: ListView.builder(
  //         itemCount: state.getTodoList.length,
  //         itemBuilder: (context, index) {
  //           return _myListContainer(index, state);
  //         },
  //       ),
  //     );
  //   } else if (state.syncingLists == false && state.todoListIsEmpty()) {
  //     return Text(
  //       "Listan är tom :) \n\nLägg till med plusset i högra hörnet.",
  //       style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),
  //     );
  //   } else {
  //     return Center(
  //       child: SpinKitRotatingCircle(
  //         color: Color.fromRGBO(69, 90, 100, 1),
  //         size: 50.0,
  //       ),
  //     );
  //   }
  // }

  Widget _myListContainer(index, state) {
    return Container(
      height: 80,
      child: Card(
        color: Color.fromRGBO(207, 216, 220, 0.8),
        margin: EdgeInsets.fromLTRB(40, 15, 40, 0),
        child: Center(
          child: CheckboxListTile(
            value: state.getValue(index, state.getTodoList),
            title: state.getTitle(index, state.getTodoList),
            //on checkbox-press sätt index till true
            onChanged: (bool newVal) {
              state.setValue(newVal, index, state.getTodoList);
            },
            controlAffinity: ListTileControlAffinity.leading,
            secondary: IconButton(
              icon: Icon(Icons.close),
              //On x-press
              onPressed: () {
                state.removeFromList(index, state.getTodoList);
              },
            ),
          ),
        ),
      ),
    );
  }
}
