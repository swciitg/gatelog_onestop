import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gate_log/gate_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const dev = String.fromEnvironment("ENV");
  await dotenv.load(fileName: ".env.$dev");
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
                      }));

                  await prefs.setString("accessToken",
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0ODExYjEyMzM1NWFkMDc2NjIzNDUiLCJpYXQiOjE3NDUwNzczOTAsImV4cCI6MTc0NTk0MTM5MH0.aIRtHkdR8DIW3dfv26Q2nft6-Pj-ZWIBhXjs7Aarhno/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0ODExYjEyMzM1NWFkMDc2NjIzNDUiLCJpYXQiOjE3NDUwNzczOTAsImV4cCI6MTc1ODAzNzM5MH0.8Ed3UnuZo5u_ATDJp3qoeGgy61tuk84UTqfvp9n_REA");

                  await prefs.setString('refreshToken',
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0ODExYjEyMzM1NWFkMDc2NjIzNDUiLCJpYXQiOjE3NDUwNzczOTAsImV4cCI6MTc0NTk0MTM5MH0.aIRtHkdR8DIW3dfv26Q2nft6-Pj-ZWIBhXjs7Aarhno/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0ODExYjEyMzM1NWFkMDc2NjIzNDUiLCJpYXQiOjE3NDUwNzczOTAsImV4cCI6MTc1ODAzNzM5MH0.8Ed3UnuZo5u_ATDJp3qoeGgy61tuk84UTqfvp9n_REA");
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
