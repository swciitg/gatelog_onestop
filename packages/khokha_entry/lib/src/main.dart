import 'package:flutter/material.dart';
import 'package:khokha_entry/src/screens/home_page.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class KhokhaEntry extends StatelessWidget {
  const KhokhaEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
