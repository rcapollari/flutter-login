import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login_form/HomePage.dart';
import 'package:login_form/User.dart';
import 'main.dart';
import 'db.dart';
import 'DatabaseHelper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  final dbHelper = DatabaseHelper.instance;

  String firstname, lastname, email, password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'First Name',
                        hintText: 'Enter first name'),
                    validator: (fname) {
                      firstname = fname;
                      if (firstname == null || firstname.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Last Name',
                        hintText: 'Enter last name'),
                    validator: (lname) {
                      lastname = lname;
                      if (lastname == null || lastname.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                        hintText: 'Example: jane.doe.civ@mail.mil'),
                    validator: (email) {
                      this.email = email;
                      if(email != null && !EmailValidator.validate(email)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 20),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (pw) {
                      password = pw;
                      if (password == null || password.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      _insert();
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
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnFirstName : firstname,
      DatabaseHelper.columnLastName : lastname,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnPass : password,
    };

    final id = await dbHelper.insert(row);
  }
}
