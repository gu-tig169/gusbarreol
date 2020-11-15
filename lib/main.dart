import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/secondPage.dart';
import 'package:todo_list/todoObject.dart';

void main() {
  runApp(Home());
}

//TODO
//1. addtolist
//2. filter
//För att lyckas, antingen passa datan till modellen eller sätta consumer i MoreButton och Home för att kunna kalla på modellen
class Home extends StatelessWidget {
  //user input från secondPage. tas in via Homes konstruktor
  final String userInput;
  Home({Key key, this.userInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => Model(),
        builder: (context, child) => Scaffold(
          appBar: _myHomeAppBar(),
          body: MyCustomListview(userInput: userInput),
          floatingActionButton: _myHomeFloatingActionButton(),
        ),
      ),
    );
  }

  Widget _myHomeAppBar() {
    return AppBar(
      title: Text("TIG169 TODO"),
      centerTitle: true,
      actions: [
        MoreButton(),
      ],
    );
  }

  Widget _myHomeFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
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

class Model extends ChangeNotifier {
  bool value = false;
  List dbArr = ["122", "2222", "3222", "apan", "sa", "inget", "112"];
  List<TodoObject> todoList = new List();

//TODO
//skapa filtrerad lista för varje med en backad lista för för "all" eller where-funktionen?
  filter(String input) {
    if (input == "all") {
    } else if (input == "done") {
    } else if (input == "undone") {}
  }

  addUserInputToTodoList(input) {
    if (input != null) {
      TodoObject obj = new TodoObject(text: input, state: false);
      todoList.add(obj);
    } else {
      print("TRIED TO ADD NULL TO TODOLIST");
    }
  }

  getTitle(index, state) {
    if (todoList[index].state == false) {
      return Text(state.todoList[index].text);
    } else if (todoList[index].state == true) {
      return Text(state.todoList[index].text,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    }
  }

//Skapar objekt av dbArr arrayen och lägger i todoList
//Byts ut om db-integration?
  createToTodoList() {
    if (todoList.length != dbArr.length) {
      for (var i = 0; i < dbArr.length; i++) {
        var obj = new TodoObject(text: dbArr[i], state: false);
        todoList.add(obj);
      }
    }
  }

  void removeFromList(index) {
    dbArr.removeAt(index);
    todoList.removeAt(index);
    notifyListeners();
  }

  List get getTodoList {
    createToTodoList();
    return todoList;
  }

  void setValue(input, index) {
    todoList[index].state = input;
    notifyListeners();
  }

  bool getValue(index) {
    return todoList[index].state;
  }
}

//kalla på addUserINputToTodoList() någonstans?!
class MyCustomListview extends StatelessWidget {
  final String userInput;
  MyCustomListview({this.userInput});
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, state, child) => ListView.builder(
        itemCount: state.getTodoList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5.0),
            child: CheckboxListTile(
              value: state.getValue(index),
              title: state.getTitle(index, state),
              //on checkbox-press sätt index till true
              onChanged: (bool newVal) {
                state.setValue(newVal, index);
              },
              controlAffinity: ListTileControlAffinity.leading,
              secondary: IconButton(
                icon: Icon(Icons.close),
                //On x-press
                onPressed: () {
                  state.removeFromList(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
