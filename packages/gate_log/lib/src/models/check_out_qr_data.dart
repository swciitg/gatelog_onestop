import 'package:gate_log/src/models/qr_model.dart';

class CheckOutQrData implements QrData {
  final String destination;
  String? connectionId;
  final String userId;

  CheckOutQrData({
    required this.destination,
    required this.userId,
    this.connectionId,
  });

  factory CheckOutQrData.fromJson(Map<String, dynamic> map) {
    return CheckOutQrData(
      userId: map['userId'],
      destination: map['destination'],
      connectionId: map['connectionId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['destination'] = destination;
    data['connectionId'] = connectionId;
    data['userId'] = userId;
    return data;
  }

  @override
  void setConnectionId(String connectionId) {
    this.connectionId = connectionId;
  }
}
