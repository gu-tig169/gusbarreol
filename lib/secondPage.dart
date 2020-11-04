import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: MyCustomAppBar(),
          body: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "What are you going to do?",
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Add"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
