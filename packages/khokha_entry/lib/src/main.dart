import 'package:flutter/material.dart';
import 'package:khokha_entry/src/screens/khokha_entry_form.dart';
import 'package:khokha_entry/src/stores/login_store.dart';

class KhokhaEntry extends StatelessWidget {
  const KhokhaEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LoginStore.saveToUserData(),
      builder: (buildContext, snapshot) {
        if (snapshot.hasData) {
          return KhokhaEntryForm();
        }
        return Scaffold();
      },
    );
  }
}
