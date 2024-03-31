abstract class QrModel {
  final String? connectionId;

  QrModel({this.connectionId});

  Map<String, dynamic> toJson();

  void setConnectionId(String connectionId);
}
