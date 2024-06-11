import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrImage extends StatelessWidget {
  final String data;

  const QrImage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      gapless: true,
      embeddedImageStyle: const QrEmbeddedImageStyle(
        color: Colors.white,
      ),
      eyeStyle: const QrEyeStyle(
        color: Colors.white,
        eyeShape: QrEyeShape.square,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.white,
        dataModuleShape: QrDataModuleShape.square,
      ),
    );
  }
}
