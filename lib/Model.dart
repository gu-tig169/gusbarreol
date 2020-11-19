import 'package:flutter/material.dart';

import 'package:todo_list/todoObject.dart';

class Model extends ChangeNotifier {
  bool value = false;
  //List dbArr = ["122", "2222", "3222", "apan", "sa", "inget", "112"];
  List<TodoObject> todoList = new List();

  List<TodoObject> filteredList = new List();
  bool filterList = false;

  filter(String input) {
    if (input == "all") {
      filterList = false;
      todoList = List.from(todoList);
      notifyListeners();
      //print("all array: $todoList");
    } else if (input == "done") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> done = todoList.where((element) {
        return element.state == true;
      }).toList();
      print("doneList: $done");

      filteredList = List.from(done);
      notifyListeners();
      //print("done array: $done");
    } else if (input == "undone") {
      filterList = true;
      filteredList.clear();
      Iterable<TodoObject> undone = todoList.where((element) {
        return element.state == false;
      }).toList();
      print("undonelist:  $undone");

      filteredList = List.from(undone);
      notifyListeners();
      //print("undone array: $undone");
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

// //Skapar objekt av dbArr arrayen och lägger i todoList
// //Byts ut om db-integration?
//   createToTodoList() {
//     if (todoList.length != dbArr.length) {
//       for (var i = 0; i < dbArr.length; i++) {
//         var obj = new TodoObject(text: dbArr[i], state: false);
//         todoList.add(obj);
//       }
//     }
//   }

  addUserInputToTodoList(input) {
    //print(input);
    if (input != null && input != "") {
      //dbArr.add(input);
      TodoObject obj = new TodoObject(text: input, state: false);
      todoList.add(obj);
      //print("TodoList length in adduser: ${todoList.length}");
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
    //dbArr.removeAt(index);
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
}
