import 'dart:math';

import 'package:flutter/material.dart';

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
