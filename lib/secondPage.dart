import 'package:flutter/material.dart';

import 'package:todo_list/main.dart';

//hämtar data från textcontainer och skicka till testArr i main
class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController inputController = TextEditingController();
    return Scaffold(
      appBar: _mySecondPageAppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
            children: [
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "What are you going to do?",
                ),
              ),
              SizedBox(height: 20),
              FlatButton.icon(
                onPressed: () {
                  inputController
                      .toString(); //<-- set toString här för att slippa bugg i main
                  //print("inputController: " + inputController.text);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Home(userInput: inputController.text)));
                },
                icon: Icon(Icons.add),
                label: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mySecondPageAppBar() {
    return AppBar(
      title: Text("TIG169"),
      centerTitle: true,
    );
  }
}
