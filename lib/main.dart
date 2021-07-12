import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:flutter_tests/Model/ToDo.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Http Requests & PODO';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.teal,
      ),
      home: MyHomePage(title: appTitle),
    );

  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoModel> myToDos = [];

  void initState() {
    load();
    super.initState();
  }

  getToDos() async {
    List<ToDoModel> myToDosParsed = [];

    var response = await get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    final List<dynamic> bodyData = json.decode(response.body);

    bodyData.forEach((toDo) {
      ToDoModel task = ToDoModel.fromJson(toDo);
      myToDosParsed.add(task);
    });

    return myToDosParsed;
  }

  load() async {
    try {
      myToDos = await getToDos();
    } catch (e) {
      print(e);
    }
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: myToDos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("User ID" + myToDos[index].userId.toString()),
              subtitle: Text(myToDos[index].title.toString()),
              trailing: myToDos[index].completed.toString() == "true" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            );
          },
        ),
      ),
    );
  }
}
