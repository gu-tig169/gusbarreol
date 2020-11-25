import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todo_list/Model/todoObject.dart';

class DB {
  //API-key: eb31ade7-d837-4c17-8d19-31aae0474e89

  //serializear JSONlistan till en lista med TodoObject.
  static getData() async {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.Response response = await http.get(url);

    Iterable l = json.decode(response.body);

    List<TodoObject> todoList =
        (l as List).map((e) => TodoObject.fromJson(e)).toList();

    return todoList;
  }

  static void postData(String text, bool state) {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.post(url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'title': text, "done": state}));
  }

  static void deleteTodoData(String id) {
    //var id = "61e3ef58-2153-4ed3-a0ea-464fd7bac9af";
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
  }

  static void putData(String id, String text, bool state) {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.put(
      url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{"title": text, "done": state}),
    );
  }
}
