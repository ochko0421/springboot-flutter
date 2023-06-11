import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'second.dart';

void main() {
  runApp(const MyApp());
}

class UserData {
  String firstName;
  String lastName;
  String gender;
  DateTime date;
  double amount;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.date,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'amount': amount,
    };
  }
}

Future<void> postData(UserData userData) async {
  final url = Uri.parse('http://localhost:8080/user');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userData.toJson()),
  );

  if (response.statusCode == 200) {
    print('Data saved successfully!');
  } else {
    print('Failed to save data. Error: ${response.statusCode}');
  }
}

void saveUserData(UserData userData) {
  postData(userData);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  DateTime? _selectedDate;
  double? _amount;

  final List<String> genders = ['Female', 'Male'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            RadioListTile<String>(
              title: Text("Male"),
              value: "Male",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("Female"),
              value: "Female",
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value);
                });
              },
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_firstName.isNotEmpty &&
                    _lastName.isNotEmpty &&
                    _gender.isNotEmpty &&
                    _selectedDate != null &&
                    _amount != null) {
                  final userData = UserData(
                    firstName: _firstName,
                    lastName: _lastName,
                    gender: _gender,
                    date: _selectedDate!,
                    amount: _amount!,
                  );
                  saveUserData(userData);
                } else {
                  print('Please fill in all fields');
                }
              },
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDataScreen()),
                );
              },
              child: const Text('See all users'),
            )
          ],
        ),
      ),
    );
  }
}
