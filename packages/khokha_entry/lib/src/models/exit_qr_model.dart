import 'package:khokha_entry/src/models/qr_model.dart';

class ExitQrModel implements QrModel {
  final String outlookEmail;
  final String name;
  final String rollNumber;
  final String hostel;
  final String program;
  final String branch;
  final String phoneNumber;
  final String roomNumber;
  final String destination;
  String? connectionId;

  ExitQrModel({
    required this.outlookEmail,
    required this.name,
    required this.rollNumber,
    required this.hostel,
    required this.program,
    required this.branch,
    required this.phoneNumber,
    required this.roomNumber,
    required this.destination,
    this.connectionId,
  });

  factory ExitQrModel.fromJson(Map<String, dynamic> map) {
    return ExitQrModel(
      outlookEmail: map['outlookEmail'],
      name: map['name'],
      rollNumber: map['rollNumber'],
      hostel: map['hostel'],
      program: map['program'],
      branch: map['branch'],
      phoneNumber: map['phoneNumber'],
      roomNumber: map['roomNumber'],
      destination: map['destination'],
      connectionId: map['connectionId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['outlookEmail'] = outlookEmail;
    data['name'] = name;
    data['rollNumber'] = rollNumber;
    data['hostel'] = hostel;
    data['program'] = program;
    data['branch'] = branch;
    data['phoneNumber'] = phoneNumber;
    data['roomNumber'] = roomNumber;
    data['destination'] = destination;
    data['connectionId'] = connectionId;
    return data;
  }

  @override
  void setConnectionId(String connectionId) {
    this.connectionId = connectionId;
  }
}
