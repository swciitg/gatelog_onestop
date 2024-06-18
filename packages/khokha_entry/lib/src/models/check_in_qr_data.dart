import 'package:khokha_entry/src/models/qr_model.dart';

class CheckInQrData implements QrData {
  String? connectionId;
  final String entryId;

  CheckInQrData({
    required this.connectionId,
    required this.entryId,
  });

  factory CheckInQrData.fromJson(Map<String, dynamic> map) {
    return CheckInQrData(
      connectionId: map['connectionId'],
      entryId: map['entryId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['connectionId'] = connectionId;
    data['entryId'] = entryId;
    return data;
  }

  @override
  void setConnectionId(String connectionId) {
    this.connectionId = connectionId;
  }
}
