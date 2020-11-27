import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:todo_list/Model/todoObject.dart';
import '../DB/DB.dart';

class Model extends ChangeNotifier {
  List<TodoObject> todoList = List();

  List<TodoObject> filteredList = new List();
  bool filterList = false;

  bool syncingLists = true;

  // Kallas på vid initieringen av appen(changenotifierprovider).
  Model() {
    _syncLists();
  }

  //Syncar locala todoList med den DB hämtar
  void _syncLists() async {
    print("working...");
    syncingLists = true;
    todoList = await DB.getData();
    notifyListeners();
    print("DONE!");
    syncingLists = false;
  }

  List get getTodoList {
    if (filterList == true) {
      return filteredList;
    }

    return todoList;
  }

  filter(String input) {
    if (input == "all") {
      filterList = false;
      todoList = List.from(todoList);
      myFlutterToast("Visar alla");
      notifyListeners();
    } else if (input == "done") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> done = todoList.where((element) {
        return element.state == true;
      }).toList();

      if (done.isEmpty) {
        myFlutterToast("Du har inga avklarade todos din lathund.");
      } else {
        filteredList = List.from(done);
        myFlutterToast("Visar avklarade");
        notifyListeners();
      }
    } else if (input == "undone") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> undone = todoList.where((element) {
        return element.state == false;
      }).toList();

      if (undone.isEmpty) {
        myFlutterToast("Alla dina todos är avklarade, snyggt!");
      } else {
        filteredList = List.from(undone);
        myFlutterToast("Visar ej avklarade");
        notifyListeners();
      }
    }
  }

  getTitle(index, list) {
    //Sträckar över om state==true
    if (list[index].state == false && list[index].text != null) {
      return Text(list[index].text);
    } else if (list[index].state == true && list[index].text != null) {
      return Text(list[index].text,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      print("GETTITLE(): tried to add null-text to list");
    }
  }

  addUserInputToTodoList(input) {
    if (input != null && input != "") {
      //TodoObject obj = new TodoObject(text: input, state: false);
      DB.postData(input, false);
      _syncLists();
    } else {
      print("ADDUSERINPUTTOTODOLIST(): Tried to add null to todoList");
    }
  }

  void removeFromList(index, list) {
    DB.deleteTodoData(list[index].id);
    _syncLists();
  }

  void setValue(input, index, list) {
    DB.putData(list[index].id, list[index].text, input);
    _syncLists();
  }

  bool getValue(index, list) {
    return list[index].state;
  }

  bool todoListIsEmpty() {
    if (todoList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  myFlutterToast(input) {
    return Fluttertoast.showToast(
      msg: input,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
