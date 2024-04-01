import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/khokha_entry_model.dart';
import 'package:khokha_entry/src/screens/khokha_entry_form.dart';
import 'package:khokha_entry/src/screens/khokha_entry_qr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/my_colors.dart';

class KhokhaHome extends StatefulWidget {
  const KhokhaHome({super.key});

  @override
  State<KhokhaHome> createState() => _KhokhaHomeState();
}

class _KhokhaHomeState extends State<KhokhaHome> {
  Future<List<KhokhaEntryModel>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString("entry_data");
    print(data);
    return data != null ? [KhokhaEntryModel.fromJson(jsonDecode(data))] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarGrey,
        title: Text(
          "All Entries",
          style: MyFonts.w500.setColor(kWhite3),
        ),
      ),
      backgroundColor: kBackground,
      body: FutureBuilder(
        future: getEntries(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: MyFonts.w500.setColor(kWhite3).size(14),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(color: lBlue2);
          }
          final data = snapshot.data!;
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No entries as of now",
                style: MyFonts.w500.setColor(kWhite3).size(14),
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final entry = data[index];
              return ListTile(
                title: Text(
                  "Destination: ${entry.destination}",
                  style: MyFonts.w500.setColor(kWhite3).size(14),
                ),
                subtitle: Text(
                  "Exit at: ${entry.outTime.hour}:${entry.outTime.minute}",
                  style: MyFonts.w500.setColor(kWhite3).size(12),
                ),
                onTap: () {
                  if (entry.inTime != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Entry already closed"),
                      ),
                    );
                    return;
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return KhokhaEntryQR(
                        model: entry,
                        destination: entry.destination,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => KhokhaEntryForm()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
