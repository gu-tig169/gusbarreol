import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todo_list/Model/todoObject.dart';

class DB {
  // https://todoapp-api-vldfm.ondigitalocean.app/
  // https://todoapp-api-vldfm.ondigitalocean.app/todos?key=1778c3bd-ee4c-42bd-a83a-99fcf7b32f15
  // API-key: eb31ade7-d837-4c17-8d19-31aae0474e89 <--gamla som slutat funka?

  static const API_KEY = "1778c3bd-ee4c-42bd-a83a-99fcf7b32f15";

  //serializear JSONlistan till en lista med TodoObject.
  static getData() async {
    var url = "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=$API_KEY";

    try {
      http.Response response = await http.get(url);

      Iterable l = json.decode(response.body);

      List<TodoObject> todoList =
          (l as List).map((e) => TodoObject.fromJson(e)).toList();

      return todoList;
    } on Exception catch (e) {
      print("ERROR I DB, antagligen har api-key gått ut: $e");
    }
  }

  static void postData(String text, bool state) async {
    var url = "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=$API_KEY";

    await http.post(url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'title': text, "done": state}));
  }

  static void deleteTodoData(String id) async {
    //var id = "61e3ef58-2153-4ed3-a0ea-464fd7bac9af";
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=$API_KEY";

    await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
  }

  static void putData(String id, String text, bool state) async {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=$API_KEY";

    await http.put(
      url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{"title": text, "done": state}),
    );
  }
}
