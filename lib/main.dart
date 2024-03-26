import 'package:flutter/material.dart';
import 'package:khokha_entry/khokha_entry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'KhokhaEntry',
      home: KhokhaEntry(),
    );
  }
}
