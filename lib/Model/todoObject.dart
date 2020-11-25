class TodoObject {
  String id;
  String text;
  var state;
  TodoObject({this.id, this.text, this.state});

  String get getId => id;
  String get getText => text;
  bool get getState => state;
  set setState(bool input) => state = input;

  factory TodoObject.fromJson(Map<dynamic, dynamic> json) {
    return TodoObject(id: json["id"], text: json["title"], state: json["done"]);
  }

  @override
  String toString() {
    return "ID: ${this.id}, TEXT: ${this.text}, STATE: ${this.state}";
  }
}
