import 'package:flutter/material.dart';
import 'package:khokha_entry/src/routing/router_config.dart';

// TODO: REMOVE ALL UNNECESSARY FILES FROM SRC FOLDER

class KhokhaEntry extends StatelessWidget {
  const KhokhaEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterConfig,
    );
  }
}
