import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/check_in_qr_data.dart';
import 'package:khokha_entry/src/models/entry_details.dart';
import 'package:khokha_entry/src/screens/scan_qr_page.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'dart:math';
import 'package:intl/intl.dart';

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
            color: OneStopColors.secondaryColor,
            borderRadius: BorderRadius.circular(27)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: (widget.entry.inTime != null || widget.entry.isClosed)
            ? Column(
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
                                  .setColor(
                                      OneStopColors.entryTileSecondaryColor)
                                  .size(12)),
                          Text(widget.entry.destination,
                              style: MyFonts.w600
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(13))
                        ],
                      ),
                      Text("Closed",
                          style: MyFonts.w500
                              .setColor(OneStopColors.entryTileStatusColor)
                              .size(12))
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exit Gate",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text("Dummy Text",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                          const SizedBox(height: 7),
                          Text(
                            "Exit Date and Time",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text(
                              "${DateFormat('dd MMM, yyyy').format(widget.entry.outTime!)}",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                          Text(
                              "${DateFormat('h:mm a').format(widget.entry.outTime!)}",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                        ],
                      ),
                      Spacer(),
                      CustomPaint(
                        painter: LinePainter(
                            firstOffset: Offset(0, -41),
                            secondOffset: Offset(0, 41),
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
                            "Entry Gate",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text("Dummy Text",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                          const SizedBox(height: 7),
                          Text(
                            "Entry Date and Time",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text(
                              "${DateFormat('dd MMM, yyyy').format(widget.entry.outTime!)}",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                          Text(
                              "${DateFormat('h:mm a').format(widget.entry.outTime!)}",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                        ],
                      ),
                    ],
                  )
                ],
              )
            : Column(
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
                                  .setColor(
                                      OneStopColors.entryTileSecondaryColor)
                                  .size(12)),
                          Text(widget.entry.destination,
                              style: MyFonts.w600
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(13))
                        ],
                      ),
                      widget.isFirst
                          ? GestureDetector(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ScanQrPage(
                                    qrData: CheckInQrData.fromJson(
                                        widget.entry.toJson()),
                                    destination: widget.entry.destination,
                                  ),
                                ));
                                setState(() {});
                              },
                              child: Container(
                                height: 23,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: OneStopColors.entryTileButtonColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text("QR",
                                        style: MyFonts.w500
                                            .setColor(
                                                OneStopColors.cardFontColor2)
                                            .size(14))),
                              ),
                            )
                          : Text("Open",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.entryTileStatusColor)
                                  .size(12))
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exit Gate",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text("Dummy Text",
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
                            "Exit Date and Time",
                            style: MyFonts.w500
                                .setColor(OneStopColors.entryTileSecondaryColor)
                                .size(10),
                          ),
                          Text(
                              "${DateFormat('dd MMM, yyyy h:mm a').format(widget.entry.outTime!)}",
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(12)),
                        ],
                      ),
                    ],
                  )
                ],
              ));
  }
}

class LinePainter extends CustomPainter {
  final Offset firstOffset;
  final Offset secondOffset;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  const LinePainter({
    required this.firstOffset,
    required this.secondOffset,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashLength = 4.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    _drawDashedLine(
        dashLength, dashSpace, firstOffset, secondOffset, canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDashedLine(double dashLength, double dashSpace, Offset firstOffset,
      Offset secondOffset, Canvas canvas, Size size, Paint paint) {
    var startOffset = firstOffset;

    var intervals = _getDirectionVector(firstOffset, secondOffset).length /
        (dashLength + dashSpace);

    for (var i = 0; i < intervals; i++) {
      var endOffset = _getNextOffset(startOffset, secondOffset, dashLength);

      /// Draw a small line.
      canvas.drawLine(startOffset, endOffset, paint);

      /// Update the starting offset.
      startOffset = _getNextOffset(endOffset, secondOffset, dashSpace);
    }
  }

  Offset _getNextOffset(
    Offset firstOffset,
    Offset secondOffset,
    double smallVectorLength,
  ) {
    var directionVector = _getDirectionVector(firstOffset, secondOffset);

    var rescaleFactor = smallVectorLength / directionVector.length;
    if (rescaleFactor.isNaN || rescaleFactor.isInfinite) {
      rescaleFactor = 1;
    }

    var rescaledVector = Offset(directionVector.vector.dx * rescaleFactor,
        directionVector.vector.dy * rescaleFactor);

    var newOffset = Offset(
        firstOffset.dx + rescaledVector.dx, firstOffset.dy + rescaledVector.dy);

    return newOffset;
  }

  DirectionVector _getDirectionVector(Offset firstVector, Offset secondVector) {
    var directionVector = Offset(
        secondVector.dx - firstVector.dx, secondVector.dy - firstVector.dy);

    var directionVectorLength =
        sqrt(pow(directionVector.dx, 2) + pow(directionVector.dy, 2));

    return DirectionVector(
      vector: directionVector,
      length: directionVectorLength,
    );
  }
}

class DirectionVector {
  final Offset vector;
  final double length;

  const DirectionVector({
    required this.vector,
    required this.length,
  });
}
