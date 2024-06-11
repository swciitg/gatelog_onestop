/*
      "entryGate": null,
      "_id": "662d433bb77dc87fbc6a1101",
      "name": "req.body.name",
      "rollNumber": "210102036",
      "outlookEmail": "r.hardik@iitg.ac.in",
      "phoneNumber": 1234567890,
      "program": "BTECH",
      "branch": "CSE",
      "hostel": "LOHIT",
      "roomNumber": "ABCD",
      "destination": "Khokha",
      "outTime": "2024-04-27T18:26:03.000Z",
      "inTime": null,
      "isClosed": false,
      "createdAt": "2024-04-27T18:26:03.701Z",
      "updatedAt": "2024-04-27T18:26:03.701Z",
      "__v": 0
*/

import 'package:khokha_entry/src/models/qr_model.dart';

class ApiModel implements QrModel {
  String? connectionId;
  final String? entryGate;
  final String id;
  final String name;
  final String rollNumber;
  final String outlookEmail;
  final int phoneNumber;
  final String program;
  final String branch;
  final String hostel;
  final String roomNumber;
  final String destination;
  final DateTime? outTime;
  final DateTime? inTime;
  final bool isClosed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  ApiModel({
    required this.connectionId,
    required this.entryGate,
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.outlookEmail,
    required this.phoneNumber,
    required this.program,
    required this.branch,
    required this.hostel,
    required this.roomNumber,
    required this.destination,
    required this.outTime,
    required this.inTime,
    required this.isClosed,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ApiModel.fromJson(Map<String, dynamic> map) {
    return ApiModel(
      connectionId: map['connectionId'],
      entryGate: map['entryGate'],
      id: map['_id'],
      name: map['name'],
      rollNumber: map['rollNumber'],
      outlookEmail: map['outlookEmail'],
      phoneNumber: map['phoneNumber'],
      program: map['program'],
      branch: map['branch'],
      hostel: map['hostel'],
      roomNumber: map['roomNumber'],
      destination: map['destination'],
      outTime: DateTime.parse(map['outTime']),
      inTime: map['inTime'] != null ? DateTime.parse(map['inTime']) : null,
      isClosed: map['isClosed'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      v: map['__v'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['connectionId'] = connectionId;
    data['entryGate'] = entryGate;
    data['_id'] = id;
    data['name'] = name;
    data['rollNumber'] = rollNumber;
    data['outlookEmail'] = outlookEmail;
    data['phoneNumber'] = phoneNumber;
    data['program'] = program;
    data['branch'] = branch;
    data['hostel'] = hostel;
    data['roomNumber'] = roomNumber;
    data['destination'] = destination;
    data['outTime'] = outTime!.toIso8601String();
    data['inTime'] = inTime?.toIso8601String();
    data['isClosed'] = isClosed;
    data['createdAt'] = createdAt!.toIso8601String();
    data['updatedAt'] = updatedAt!.toIso8601String();
    data['__v'] = v;
    return data;
  }

  @override
  void setConnectionId(String connectionId) {
    this.connectionId = connectionId;
  }
}
