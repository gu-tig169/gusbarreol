import 'dart:convert';
import 'package:http/http.dart' as http;

class DB {
  //API-key: eb31ade7-d837-4c17-8d19-31aae0474e89

  //fönkar
  static void getData() async {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.Response response = await http.get(url);
    var content = response.body;
    List todoList = json.decode(content);
    print(todoList.length);
  }

  //Fönkar
  static void postData() async {
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.Response response = await http.post(url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(
            <String, String>{'title': "test", "done": false.toString()}));

    print(response.body);
  }

  //Fönkar
  static void deleteTodoData() async {
    var id = "f105961b-ac39-4294-9bda-f87ee198c935";
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    print(jsonDecode(response.body));
  }

  //Fönkar
  static void putData() {
    var id = "79e0ccea-45b1-452f-8651-e8a7b7889e02";
    var url =
        "https://todoapp-api-vldfm.ondigitalocean.app/todos/$id?key=eb31ade7-d837-4c17-8d19-31aae0474e89";

    Future<http.Response> response = http.put(
      url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
          <String, String>{'title': "APA", "done": false.toString()}),
    );

    print(response.toString());
  }
}
