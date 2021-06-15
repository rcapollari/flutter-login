import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> list = new List();
  final dbHelper = DatabaseHelper.instance;
  User model;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  fetch() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => {
          model = User(
              row["firstname"], row["lastname"], row["email"], row["password"]),
          list.add(model)
        });
    setState(() {});
  }
}
