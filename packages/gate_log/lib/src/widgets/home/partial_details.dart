import 'package:flutter/material.dart';
import 'package:gate_log/src/globals/my_fonts.dart';
import 'package:gate_log/src/models/check_in_qr_data.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/screens/scan_qr_page.dart';
import 'package:gate_log/src/widgets/home/line_painter.dart';
import 'package:intl/intl.dart';
import 'package:onestop_kit/onestop_kit.dart';

class PartialDetails extends StatefulWidget {
  final EntryDetails details;
  final bool isFirst;

  const PartialDetails(
      {required this.isFirst, required this.details, super.key});

  @override
  State<PartialDetails> createState() => _PartialDetailsState();
}

class _PartialDetailsState extends State<PartialDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Destination",
                    style: MyFonts.w500
                        .setColor(OneStopColors.onSecondaryColor2)
                        .size(12)),
                Text(widget.details.destination,
                    style: MyFonts.w600
                        .setColor(OneStopColors.cardFontColor2)
                        .size(13))
              ],
            ),
            widget.isFirst
                ? GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScanQrPage(
                          qrData:
                              CheckInQrData.fromJson(widget.details.toJson()),
                          destination: widget.details.destination,
                        ),
                      ));
                      setState(() {});
                    },
                    child: Container(
                      height: 23,
                      width: 45,
                      decoration: BoxDecoration(
                          color: OneStopColors.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text("QR",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.backgroundColor)
                                  .size(14))),
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: OneStopColors.greenTextColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("Open",
                        style: MyFonts.w500
                            .setColor(OneStopColors.greenTextColor)
                            .size(12)),
                  )
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check-Out Gate",
                  style: MyFonts.w500
                      .setColor(OneStopColors.onSecondaryColor2)
                      .size(10),
                ),
                Text(widget.details.checkOutGate,
                    style: MyFonts.w500
                        .setColor(OneStopColors.cardFontColor2)
                        .size(12)),
              ],
            ),
            Spacer(),
            CustomPaint(
              painter: LinePainter(
                  firstOffset: Offset(0, -1 * 13),
                  secondOffset: Offset(0, 13),
                  color: OneStopColors.cardFontColor1,
                  strokeWidth: 1,
                  dashLength: 2,
                  dashSpace: 2),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check-Out Date and Time",
                  style: MyFonts.w500
                      .setColor(OneStopColors.onSecondaryColor2)
                      .size(10),
                ),
                Text(
                    DateFormat('dd MMM, yyyy h:mm a')
                        .format(widget.details.checkOutTime),
                    style: MyFonts.w500
                        .setColor(OneStopColors.cardFontColor2)
                        .size(12)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
