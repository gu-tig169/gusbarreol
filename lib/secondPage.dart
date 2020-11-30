import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/Model/Model.dart';

//hämtar data från textcontainer och skicka till main
class AddTaskPage extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      builder: (context, child) => Scaffold(
        appBar: _mySecondPageAppBar(),
        body: _mySecondPageBody(context),
      ),
    );
  }

  Widget _mySecondPageAppBar() {
    return AppBar(
      title: Text("TODO"),
      centerTitle: true,
    );
  }

  Widget _mySecondPageBody(context) {
    return Consumer<Model>(
      builder: (context, state, child) => Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
            children: [
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Skriv här:",
                ),
              ),
              SizedBox(height: 20),
              FlatButton.icon(
                onPressed: () {
                  //Här ska poppas istället för pusha nytt objekt på stacken
                  if (inputController.text == "") {
                    state.myFlutterToast(
                        "Skriv något i rutan för att lägga till en TODO.");
                  } else {
                    Navigator.pop(context, inputController.text);
                  }
                },
                icon: Icon(Icons.add),
                label: Text("Lägg till"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
