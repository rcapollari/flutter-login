import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'HomePage.dart';
import 'Register.dart';
import 'User.dart';
import 'DatabaseHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Login Page"),
          ),
          body: SingleChildScrollView(
            child: LoginDemo(),
          ),
        ),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _formKey = GlobalKey<FormState>();
  List<User> list = new List();
  final dbHelper = DatabaseHelper.instance;
  User model;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 30),
            child: Center(
              child: Container(
                width: 200,
                height: 105,
                child: Image.asset('assets/images/gvsc.png')
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Email',
                  hintText: 'Example: jane.doe.civ@mail.mil'),
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Please enter a valid email address'
                      : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 20),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
              validator: (password) {
                if (password == null || password.isEmpty) {
                  return 'Please enter your password.';
                } else if (password != "test") {
                  return 'Incorrect password';
                }
                return null;
              },
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise
                final FormState form = _formKey.currentState;
                if(form.validate()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => HomePage()));
                }
                else {
                  print('form is invalid');
                }
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New User?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
