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
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjRmNzhmM2FhZTg2NDIyNzU0YjE2ZjMiLCJpYXQiOjE3MjQwNTc5MDEsImV4cCI6MTcyNDkyMTkwMX0.XMfpKTpTYYE2ozfIvTSWL1dM_CGlTh1H_A6u4C37rD0");

                  await prefs.setString('refreshToken',
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGQwNWExNmExOTJjMGExMDYzOWQ4OWEiLCJpYXQiOjE3Mzk3MDM0ODYsImV4cCI6MTc1MjY2MzQ4Nn0.mPI1sUrW-T3Knvf9flpdL5ywFffKYKzP2exjRVFhfls");
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
