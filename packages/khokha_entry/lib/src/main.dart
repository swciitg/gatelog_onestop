import 'package:flutter/material.dart';
import 'package:khokha_entry/src/routing/router_config.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
    
class KhokhaEntry extends StatelessWidget {
  const KhokhaEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterConfig,
    );
  }
}
