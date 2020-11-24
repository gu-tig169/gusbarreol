class TodoObject {
  String text;
  bool state;
  TodoObject({this.text, this.state});

  String get getText => text;
  bool get getState => state;
  set setState(bool input) => state = input;
}
