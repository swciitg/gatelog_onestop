import 'package:khokha_entry/src/models/qr_model.dart';

class ExitQrModel implements QrModel {
  final String destination;
  String? connectionId;
  final String userId;

  ExitQrModel({
    required this.destination,
    required this.userId,
    this.connectionId,
  });

  factory ExitQrModel.fromJson(Map<String, dynamic> map) {
    return ExitQrModel(
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
