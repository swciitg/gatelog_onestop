import 'package:khokha_entry/src/models/qr_model.dart';

class KhokhaEntryModel implements QrModel {
  String? connectionId;
  final String destination;
  final String entryId;
  final DateTime outTime;
  final DateTime? inTime;

  KhokhaEntryModel({
    required this.connectionId,
    required this.destination,
    required this.entryId,
    required this.outTime,
    this.inTime,
  });

  factory KhokhaEntryModel.fromJson(Map<String, dynamic> map) {
    return KhokhaEntryModel(
      connectionId: map['connectionId'],
      destination: map['destination'],
      entryId: map['entryId'],
      outTime: DateTime.parse(map['outTime']),
      inTime: map['inTime'] != null ? DateTime.parse(map['inTime']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['connectionId'] = connectionId;
    data['destination'] = destination;
    data['entryId'] = entryId;
    data['outTime'] = outTime.toIso8601String();
    data['inTime'] = inTime?.toIso8601String();
    return data;
  }

  @override
  void setConnectionId(String connectionId) {
    this.connectionId = connectionId;
  }
}
