import 'package:flutter/material.dart';
import 'package:gate_log/src/models/check_in_qr_data.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/screens/scan_qr_page.dart';
import 'package:gate_log/src/widgets/home/line_painter.dart';
import 'package:intl/intl.dart';
import 'package:onestop_kit/onestop_kit.dart';

class PartialDetails extends StatelessWidget {
  final EntryDetails details;
  final bool isFirst;
  final VoidCallback onCheckIn;

  const PartialDetails({
    super.key,
    required this.isFirst,
    required this.details,
    required this.onCheckIn,
  });

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
            isFirst
                ? GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScanQrPage(
                          qrData: CheckInQrData.fromJson(details.toJson()),
                          destination: details.destination,
                        ),
                      ));
                      onCheckIn();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: OneStopColors.kYellow.withAlpha(30),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text("Check-In",
                              style: OnestopFonts.w500
                                  .setColor(OneStopColors.kYellow)
                                  .size(12))),
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: OneStopColors.greenTextColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("Open",
                        style: OnestopFonts.w500
                            .setColor(OneStopColors.greenTextColor)
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
                ],
              ),
            ),
            CustomPaint(
              painter: LinePainter(
                  firstOffset: Offset(0, -1 * 13),
                  secondOffset: Offset(0, 13),
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
