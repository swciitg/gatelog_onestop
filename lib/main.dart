import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khokha_entry/khokha_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KhokhaEntry',
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      'userInfo',
                      jsonEncode({
                        'outlookEmail': 'r.hardik@iitg.ac.in',
                        'name': 'Hardik Roongta',
                        'rollNo': '210102036',
                        'altEmail': 'abc@gmail.com',
                        'phoneNumber': 1234567890,
                        'emergencyPhoneNumber': 0987654321,
                        'gender': 'Male',
                        'roomNo': 'ABCD',
                        'homeAddress': 'homeAddress',
                        'dob': 'dob',
                        'hostel': 'Lohit',
                        'linkedin': 'linkedin',
                        'image': 'image',
                      }));
  
                  await prefs.setString("accessToken",
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjRmNzhmM2FhZTg2NDIyNzU0YjE2ZjMiLCJpYXQiOjE3MTgwODQ0NjEsImV4cCI6MTcxODk0ODQ2MX0.T0R8hdUndkEJOVrFdujniuxTAEAmzrhpYeQCLw3eSzE");
                  await prefs.setBool('isGuest', false);

                  nav.pushReplacement(MaterialPageRoute(
                    builder: (context) => const KhokhaEntry(),
                  ));
                },
                child: const Text('KhokhaEntry')),
          ),
        );
      }),
    );
  }
}
