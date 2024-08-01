import 'package:flutter/material.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/widgets/home/full_details.dart';
import 'package:gate_log/src/widgets/home/partial_details.dart';
import 'package:onestop_kit/onestop_kit.dart';

class EntryDetailsTile extends StatelessWidget {
  const EntryDetailsTile({
    super.key,
    required this.entry,
    required this.isFirst,
    required this.onCheckIn,
  });

  final EntryDetails entry;
  final bool isFirst;
  final VoidCallback onCheckIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OneStopColors.cardColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 15, 16),
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: entry.isClosed
          ? FullDetails(details: entry)
          : PartialDetails(
              isFirst: isFirst,
              details: entry,
              onCheckIn: onCheckIn,
            ),
    );
  }
}
