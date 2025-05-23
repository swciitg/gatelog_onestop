import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gate_log/gate_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GateLog',
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
                        'hostel': 'LOHIT',
                        'linkedin': 'linkedin',
                        'image': 'image',
                        'cycleReg' : "11588",
                      }));

                  await prefs.setString("accessToken",
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2N2Y3YTg0MzhhYjE2ODk3ZTU2MDZhZDIiLCJpYXQiOjE3NDU0MTA2NzcsImV4cCI6MTc0NjI3NDY3N30.lqva4QuvEe5dq8vj76u0TW0gRhaG15ItyBT2mmZzk8c");

                  await prefs.setString('refreshToken',
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2N2Y3YTg0MzhhYjE2ODk3ZTU2MDZhZDIiLCJpYXQiOjE3NDU0MTA2NzcsImV4cCI6MTc1ODM3MDY3N30.vHl6r2ZPaEsO76xkSlGITh1X1sL5g27rEZ7E6euhDyY");
                  await prefs.setBool('isGuest', false);

                  nav.push(MaterialPageRoute(
                    builder: (context) => const GateLog(),
                  ));
                },
                child: const Text('GateLog')),
          ),
        );
      }),
    );
  }
}
