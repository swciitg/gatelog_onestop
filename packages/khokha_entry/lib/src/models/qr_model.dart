abstract class QrData {
  final String? connectionId;

  QrData({this.connectionId});

  Map<String, dynamic> toJson();

  void setConnectionId(String connectionId);
}
