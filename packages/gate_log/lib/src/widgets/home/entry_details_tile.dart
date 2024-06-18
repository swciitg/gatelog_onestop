import 'package:flutter/material.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/widgets/home/full_details.dart';
import 'package:gate_log/src/widgets/home/partial_details.dart';
import 'package:onestop_kit/onestop_kit.dart';

class EntryDetailsTile extends StatefulWidget {
  const EntryDetailsTile(
      {super.key, required this.entry, required this.isFirst});

  final EntryDetails entry;
  final bool isFirst;

  @override
  State<EntryDetailsTile> createState() => _EntryDetailsTileState();
}

class _EntryDetailsTileState extends State<EntryDetailsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OneStopColors.cardColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: widget.entry.isClosed
          ? FullDetails(details: widget.entry)
          : PartialDetails(
              isFirst: widget.isFirst,
              details: widget.entry,
            ),
    );
  }
}
