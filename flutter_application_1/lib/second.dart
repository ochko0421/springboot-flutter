import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime date;
  final double amount;

  User({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.date,
    required this.amount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
    );
  }
}

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  List<User> _users = [];
  User? selectedUser;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final url = Uri.parse('http://localhost:8080/user');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<User> users =
          responseData.map((data) => User.fromJson(data)).toList();

      setState(() {
        _users = users;
      });
    } else {
      print('Failed to fetch user data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: Center(
        child: DropdownButton<User>(
          hint: const Text('Select User'),
          value: selectedUser,
          onChanged: (User? value) {
            setState(() {
              selectedUser = value;
            });
          },
          items: _users.map((User userData) {
            final formattedDate =
                DateFormat('MMMM d, yyyy').format(userData.date);

            return DropdownMenuItem<User>(
              value: userData,
              child: Text(
                  '${userData.firstName} ${userData.lastName} ${userData.gender} $formattedDate ${userData.amount}usd'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
