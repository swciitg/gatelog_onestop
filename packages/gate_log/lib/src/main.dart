import 'package:flutter/material.dart';
import 'package:gate_log/src/screens/home_page.dart';

final GlobalKey<ScaffoldMessengerState> gatelogRootScaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

class GateLog extends StatelessWidget {
  const GateLog({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
