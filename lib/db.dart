/*import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'user_database.db'),

    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, firstname TEXT, '
              'lastname TEXT, email TEXT, password TEXT)');
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts users into the database
  Future<void> insertUser(User user) async {
    // Get a reference to the database
    final db = await database;

    // Insert the User into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    // In this case, replace any previous data.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the users from the users table
  Future<List<User>> users() async {
    // Get a reference to the database
    final db = await database;

    // Query the table for all the Users
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        firstname: maps[i]['firstname'],
        lastname: maps[i]['lastname'],
        email: maps[i]['email'],
        password: maps[i]['password'],
    );
    });
  }

  Future<void> updateUser(User user) async {
    // Get a reference to the database
    final db = await database;

    // Update the given User
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the User has a matching id
      where: 'id = ?',
      // Pass the User's id as a WhereArg to prevent SQL injection
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database
    final db = await database;

    // Remove the User from the database
    await db.delete(
      'users',
      // Use a 'where' clause to delete a specific user
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection
      whereArgs: [id],
    );
  }

  // Create a User and add it to the users table
  var user1 = User(
    id: 0,
    firstname: 'Jane',
    lastname: 'Doe',
    email: 'user1@gmail.com',
    password: 'demo',
  );

  await insertUser(user1);

  // Now user the method above to retrieve all the users
  print(await users()); // Prints a list that includes user1

  // Update user1's email and save it to the database
  user1 = User(
    id: user1.id,
    firstname: user1.firstname,
    lastname: user1.lastname,
    email: 'jane.doe.civ@mail.mil',
    password: user1.password,
  );
  await updateUser(user1);

  // Print the updated results
  print(await users());

  // Delete user1 from the database
  await deleteUser(user1.id);

  // Print the empty list of users
  print(await users());
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json['id'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    password: json['password'],
  );

  // Convert a User into a Map. The keys must correspond to the names of
  // the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, '
        'email: $email, password: $password)';
  }
}
*/
