import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/endpoints.dart';
import 'package:khokha_entry/src/globals/my_colors.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/khokha_entry_model.dart';
import 'package:khokha_entry/src/models/khokha_exit_model.dart';
import 'package:khokha_entry/src/models/qr_model.dart';
import 'package:khokha_entry/src/utility/auth_user_helpers.dart';
import 'package:khokha_entry/src/utility/enums.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class KhokhaEntryQR extends StatefulWidget {
  const KhokhaEntryQR({
    super.key,
    required this.model,
    required this.destination,
  });

  final QrModel model;
  final String destination;

  @override
  State<KhokhaEntryQR> createState() => _KhokhaEntryQRState();
}

class _KhokhaEntryQRState extends State<KhokhaEntryQR> {
  void initWebSocket() async {
    final channel = IOWebSocketChannel.connect(
      Uri.parse(Endpoints.webSocketUrl),
      headers: {
        'Content-Type': 'application/json',
        'security-key': Endpoints.onestopSecurityKey,
        'Authorization': "Bearer ${await AuthUserHelpers.getAccessToken()}",
      },
    );
    print("connecting to websocket..");
    await channel.ready;
    print("connecting successful..");
    channel.stream.listen((event) async {
      final prefs = await SharedPreferences.getInstance();
      final nav = Navigator.of(context);
      final eventMap = jsonDecode(event);
      print(eventMap);
      final eventName = eventMap['eventName'];
      if (eventName == SocketEvents.CONNECTION.name) {
        widget.model.setConnectionId(eventMap['connectionId']);
        setState(() {});
      } else if (eventName == SocketEvents.TIMEOUT.name) {
        await channel.sink.close();
        initWebSocket();
        setState(() {});
      } else if (eventName == SocketEvents.ENTRY_ADDED.name) {
        final data = widget.model as KhoKhaExitModel;
        print(eventMap['data']['outTime']);
        final outTime = DateTime.parse(eventMap['data']['outTime'].toString());
        final model = KhokhaEntryModel(
          connectionId: widget.model.connectionId,
          destination: data.destination,
          entryId: eventMap['data']['_id'],
          outTime: outTime,
        );
        prefs.setString("entry_data", jsonEncode(model.toJson()));
        nav.pop();
        nav.pop();
      } else if (eventName == SocketEvents.ENTRY_CLOSED.name) {
        final data = await prefs.getString("entry_data");
        final map = jsonDecode(data!);
        final model = KhokhaEntryModel(
          connectionId: widget.model.connectionId,
          destination: map['destination'],
          entryId: eventMap['data']['_id'],
          outTime: DateTime.parse(map['outTime']),
          inTime: DateTime.parse(eventMap['data']['inTime']),
        );
        print(model.toJson());
        prefs.setString("entry_data", jsonEncode(model.toJson()));
      }
      debugPrint("WebSocket: $event");
    });
  }

  @override
  void initState() {
    initWebSocket();
    super.initState();
  }

  QrImageView getQRImage(String data) {
    final width = MediaQuery.of(context).size.width;
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: width * 0.6,
      gapless: false,
      embeddedImageStyle: const QrEmbeddedImageStyle(
        color: Colors.white,
      ),
      eyeStyle: const QrEyeStyle(
        color: Colors.white,
        eyeShape: QrEyeShape.square,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: Colors.white,
        dataModuleShape: QrDataModuleShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isExit = widget.model is KhoKhaExitModel;
    return AlertDialog(
      backgroundColor: kAppBarGrey,
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.6,
            height: width * 0.6,
            child: getQRImage(jsonEncode(widget.model.toJson())),
          ),
          const SizedBox(height: 16),
          if (isExit)
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Destination: ',
                    style: MyFonts.w500.setColor(kWhite3).size(14),
                  ),
                  TextSpan(
                    text: widget.destination,
                    style: MyFonts.w500.setColor(lBlue2).size(14),
                  ),
                ],
              ),
            ),
          if (!isExit)
            Builder(builder: (context) {
              final data = widget.model as KhokhaEntryModel;
              final time = data.outTime;
              final destination = data.destination;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Entry Added at: ${time.hour}: ${time.minute}",
                    style: MyFonts.w500.setColor(kWhite3).size(14),
                  ),
                  Text(
                    "Destination: $destination",
                    style: MyFonts.w500.setColor(kWhite3).size(14),
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }
}
