import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/khokha_entry_model.dart';
import 'package:khokha_entry/src/routing/app_routes.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
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
                return Card(
                  color: kAppBarGrey,
                  child: ListTile(
                    title: Text(
                      "Destination: ${entry.destination}",
                      style: MyFonts.w500.setColor(kWhite3).size(18),
                    ),
                    trailing: Text(
                      "Status: ${entry.inTime == null ? "Open" : "Closed"}",
                      style: MyFonts.w500.setColor(kWhite3).size(12),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exit at: ${entry.outTime.toLocal().hour}:${entry.outTime.toLocal().minute}",
                          style: MyFonts.w500.setColor(kWhite3).size(12),
                        ),
                        if (entry.inTime != null)
                          Text(
                            "Entry at: ${entry.inTime!.toLocal().hour}:${entry.inTime!.toLocal().minute}",
                            style: MyFonts.w500.setColor(kWhite3).size(12),
                          )
                      ],
                    ),
                    onTap: () async {
                      if (entry.inTime != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Entry already closed"),
                          ),
                        );
                        return;
                      }
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return KhokhaEntryQR(
                            model: entry,
                            destination: entry.destination,
                          );
                        },
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lBlue2,
        onPressed: () async {
          await context.pushNamed(AppRoutes.entryFormScreen.name);
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: kBlack,
        ),
      ),
    );
  }
}
