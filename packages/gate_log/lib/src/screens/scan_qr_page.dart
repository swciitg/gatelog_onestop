import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gate_log/src/globals/endpoints.dart';
import 'package:gate_log/src/globals/my_fonts.dart';
import 'package:gate_log/src/models/check_out_qr_data.dart';
import 'package:gate_log/src/models/qr_model.dart';
import 'package:gate_log/src/screens/home_page.dart';
import 'package:gate_log/src/utility/enums.dart';
import 'package:gate_log/src/widgets/custom_app_bar.dart';
import 'package:gate_log/src/widgets/qrScreen/qr_image.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:web_socket_channel/io.dart';

class ScanQrPage extends StatefulWidget {
  final QrData qrData;
  final String destination;

  const ScanQrPage({
    super.key,
    required this.qrData,
    required this.destination,
  });

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late IOWebSocketChannel channel;

  void initWebSocket() async {
    channel = IOWebSocketChannel.connect(
      Uri.parse(Endpoints.khokhaWebSocketUrl),
      headers: {
        'Content-Type': 'application/json',
        'security-key': Endpoints.onestopSecurityKey,
        'Authorization': "Bearer ${await AuthUserHelpers.getAccessToken()}",
      },
    );
    print("connecting to websocket..");
    await channel.ready;
    print("connecting successful..");
    channel.stream.listen(
      (event) async {
        final nav = Navigator.of(context);
        final eventMap = jsonDecode(event);
        print(eventMap);
        final eventName = eventMap['eventName'];

        if (eventName == SocketEvents.CONNECTION.name) {
          setState(() {
            widget.qrData.setConnectionId(eventMap['connectionId']);
          });
        } else if (eventName == SocketEvents.TIMEOUT.name) {
          await channel.sink.close();

          setState(() {
            initWebSocket();
          });
        } else if (eventName == SocketEvents.ENTRY_ADDED.name) {
          nav.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false);
        } else if (eventName == SocketEvents.ENTRY_CLOSED.name) {
          nav.pop();
        } else if (eventName == SocketEvents.ERROR.name) {
          nav.pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong!")));
        }
      },
      onError: (error, stackTrace) {
        print("Error: $error");
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong!")));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  void initState() {
    initWebSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isExit = widget.qrData is CheckOutQrData;
    Map json = widget.qrData.toJson();
    json['isExit'] = isExit;
    print(json);

    return Scaffold(
      backgroundColor: OneStopColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Scan the QR',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: OneStopColors.cardColor1,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.7,
                          height: width * 0.7,
                          child: json['connectionId'] == null
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: OneStopColors.primaryColor,
                                  ),
                                )
                              : QrImage(data: jsonEncode(json)),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Destination: ',
                              style: MyFonts.w500
                                  .setColor(OneStopColors.cardFontColor2)
                                  .size(18),
                            ),
                            TextSpan(
                              text: widget.destination,
                              style: MyFonts.w500
                                  .setColor(OneStopColors.primaryColor)
                                  .size(18),
                            ),
                          ]),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/swc_ec_logo.png',
                package: 'gate_log',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
