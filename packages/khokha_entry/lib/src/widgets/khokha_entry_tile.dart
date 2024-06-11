import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/entry_details.dart';
import 'package:khokha_entry/src/screens/khokha_entry_qr.dart';
import 'package:onestop_kit/onestop_kit.dart';

class KhokhaEntryTile extends StatefulWidget {
  const KhokhaEntryTile({Key? key, required this.entry}) : super(key: key);

  final EntryDetails entry;
  @override
  State<KhokhaEntryTile> createState() => _KhokhaEntryTileState();
}

class _KhokhaEntryTileState extends State<KhokhaEntryTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: OneStopColors.secondaryColor,
      child: ListTile(
        title: Text(
          "Destination: ${widget.entry.destination}",
          style: MyFonts.w500.setColor(OneStopColors.cardFontColor2).size(18),
        ),
        trailing: Text(
          "Status: ${widget.entry.inTime == null ? "Open" : "Closed"}",
          style: MyFonts.w500.setColor(OneStopColors.cardFontColor2).size(12),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exit at: ${widget.entry.outTime?.toLocal().hour}:${widget.entry.outTime?.toLocal().minute}",
              style:
                  MyFonts.w500.setColor(OneStopColors.cardFontColor2).size(12),
            ),
            if (widget.entry.inTime != null)
              Text(
                "Entry at: ${widget.entry.inTime!.toLocal().hour}:${widget.entry.inTime!.toLocal().minute}",
                style: MyFonts.w500
                    .setColor(OneStopColors.cardFontColor2)
                    .size(12),
              )
          ],
        ),
        onTap: () async {
          if (widget.entry.inTime != null) {
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
                model: widget.entry,
                destination: widget.entry.destination,
              );
            },
          );
          setState(() {});
        },
      ),
    );
  }
}
