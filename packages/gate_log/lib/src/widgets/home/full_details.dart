import 'package:flutter/material.dart';
import 'package:gate_log/src/globals/my_fonts.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/widgets/home/line_painter.dart';
import 'package:intl/intl.dart';
import 'package:onestop_kit/onestop_kit.dart';

class FullDetails extends StatefulWidget {
  final EntryDetails details;

  const FullDetails({required this.details, super.key});

  @override
  State<FullDetails> createState() => _FullDetailsState();
}

class _FullDetailsState extends State<FullDetails> {
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: OneStopColors.errorRed.withAlpha(25),
                  borderRadius: BorderRadius.circular(8)),
              child: Text("Closed",
                  style:
                      MyFonts.w500.setColor(OneStopColors.errorRed).size(12)),
            )
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Column(
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
                  const SizedBox(height: 7),
                  Text(
                    "Check-Out Date & Time",
                    style: MyFonts.w500
                        .setColor(OneStopColors.onSecondaryColor2)
                        .size(10),
                  ),
                  Text(
                    DateFormat('MMM dd, h:mm a')
                        .format(widget.details.checkOutTime.toLocal()),
                    style: MyFonts.w500
                        .setColor(OneStopColors.cardFontColor2)
                        .size(12),
                  ),
                ],
              ),
            ),
            CustomPaint(
              painter: LinePainter(
                  firstOffset: Offset(0, -41),
                  secondOffset: Offset(0, 41),
                  color: OneStopColors.cardFontColor1,
                  strokeWidth: 1,
                  dashLength: 2,
                  dashSpace: 2),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-In Gate",
                      style: MyFonts.w500
                          .setColor(OneStopColors.onSecondaryColor2)
                          .size(10),
                    ),
                    Text(widget.details.checkInGate!,
                        style: MyFonts.w500
                            .setColor(OneStopColors.cardFontColor2)
                            .size(12)),
                    const SizedBox(height: 7),
                    Text(
                      "Check-In Date & Time",
                      style: MyFonts.w500
                          .setColor(OneStopColors.onSecondaryColor2)
                          .size(10),
                    ),
                    Text(
                        DateFormat('MMM dd, h:mm a')
                            .format(widget.details.checkOutTime.toLocal()),
                        style: MyFonts.w500
                            .setColor(OneStopColors.cardFontColor2)
                            .size(12)),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
