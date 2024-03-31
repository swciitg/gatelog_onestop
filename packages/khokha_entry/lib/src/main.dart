import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:khokha_entry/src/screens/khokha_entry_form.dart';
import 'package:khokha_entry/src/screens/khokha_home.dart';
import 'package:khokha_entry/src/stores/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhokhaEntry extends StatelessWidget {
  const KhokhaEntry({super.key});

  Future<bool> initialise() async {
    SharedPreferences user = await SharedPreferences.getInstance();

    // venkatesh.m@iitg.ac.in
    // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGQwNWExNmExOTJjMGExMDYzOWQ4OWEiLCJpYXQiOjE3MTE4MTcyNzIsImV4cCI6MTcxMjY4MTI3Mn0.by5rrzWMOamDQ_c5-R5K5n3MWZ7B5tKg_RbEH0BJa1E

    await user.setString(
        "userInfo",
        jsonEncode({
          "_id": "64a9bf9aac3eab0197b5b67e",
          "name": "Venkatesh M",
          "outlookEmail": "venkatesh.m@iitg.ac.in",
          "rollNo": "220101110",
          "roomNo": "142",
          "hostel": "Dihing",
          "__v": 0
        }));

    await user.setString("accessToken",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NTE0MzdkYWIxMjgxNmNhODkwYTQzM2MiLCJpYXQiOjE3MTE4MjE5ODgsImV4cCI6MTcxMjY4NTk4OH0.Q6sl0I6JDK-WNuFWd4-pKOBxEE3WSK7h11PEIz9ya_o");
    await LoginStore.saveToUserData();
    print("set user data");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return KhokhaHome();
  }
}
