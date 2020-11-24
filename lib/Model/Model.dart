import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:todo_list/Model/todoObject.dart';
import '../DB/DB.dart';

class Model extends ChangeNotifier {
  List<TodoObject> todoList = new List();

  List<TodoObject> filteredList = new List();
  bool filterList = false;

  // // Kallas på vid initieringen av appen(changenotifierprovider).
  Model() {
    //DB.getData();
    //DB.postData();
    //DB.deleteTodoData();
    //DB.putData();
  }

  filter(String input) {
    if (input == "all") {
      filterList = false;
      todoList = List.from(todoList);
      notifyListeners();
    } else if (input == "done") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> done = todoList.where((element) {
        return element.state == true;
      }).toList();

      filteredList = List.from(done);
      notifyListeners();
    } else if (input == "undone") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> undone = todoList.where((element) {
        return element.state == false;
      }).toList();

      filteredList = List.from(undone);
      notifyListeners();
    }
  }

  getTitle(index, list) {
    //Sträckar över om state==true
    if (list[index].state == false) {
      return Text(list[index].text);
    } else if (list[index].state == true) {
      return Text(list[index].text,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    }
  }

  addUserInputToTodoList(input) {
    if (input != null && input != "") {
      TodoObject obj = new TodoObject(text: input, state: false);
      todoList.add(obj);
      notifyListeners();
    } else {
      //print("TRIED TO ADD NULL TO TODOLIST");
    }
  }

  List get getTodoList {
    if (filterList == true) {
      return filteredList;
    }
    return todoList;
  }

  void removeFromList(index, list) {
    list.removeAt(index);
    notifyListeners();
  }

  void setValue(input, index, list) {
    list[index].state = input;
    notifyListeners();
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
