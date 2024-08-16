import 'package:flutter/material.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/widgets/home/line_painter.dart';
import 'package:intl/intl.dart';
import 'package:onestop_kit/onestop_kit.dart';

class FullDetails extends StatelessWidget {
  final EntryDetails details;

  const FullDetails({required this.details, super.key});

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
                    style: OnestopFonts.w500
                        .setColor(OneStopColors.onSecondaryColor2)
                        .size(12)),
                Text(details.destination,
                    style: OnestopFonts.w600
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
                  style: OnestopFonts.w500
                      .setColor(OneStopColors.errorRed)
                      .size(12)),
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
                    style: OnestopFonts.w500
                        .setColor(OneStopColors.onSecondaryColor2)
                        .size(10),
                  ),
                  Text(details.checkOutGate,
                      style: OnestopFonts.w500
                          .setColor(OneStopColors.cardFontColor2)
                          .size(12)),
                  const SizedBox(height: 7),
                  Text(
                    "Check-Out Date & Time",
                    style: OnestopFonts.w500
                        .setColor(OneStopColors.onSecondaryColor2)
                        .size(10),
                  ),
                  Text(
                    DateFormat('MMM dd, h:mm a')
                        .format(details.checkOutTime.toLocal()),
                    style: OnestopFonts.w500
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
                      style: OnestopFonts.w500
                          .setColor(OneStopColors.onSecondaryColor2)
                          .size(10),
                    ),
                    Text(details.checkInGate ?? 'N/A',
                        style: OnestopFonts.w500
                            .setColor(OneStopColors.cardFontColor2)
                            .size(12)),
                    const SizedBox(height: 7),
                    Text(
                      "Check-In Date & Time",
                      style: OnestopFonts.w500
                          .setColor(OneStopColors.onSecondaryColor2)
                          .size(10),
                    ),
                    Text(
                        details.checkInTime == null
                            ? 'N/A'
                            : DateFormat('MMM dd, h:mm a')
                                .format(details.checkInTime!.toLocal()),
                        style: OnestopFonts.w500
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
