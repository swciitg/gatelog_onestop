class EntryDetails {
  final String entryId;
  final String name;
  final String rollNumber;
  final String outlookEmail;
  final int phoneNumber;
  final String hostel;
  final String roomNumber;
  final String destination;
  final DateTime checkOutTime;
  final String checkOutGate;
  final DateTime? checkInTime;
  final String? checkInGate;
  final bool isClosed;

  EntryDetails({
    required this.checkOutGate,
    required this.checkInGate,
    required this.entryId,
    required this.name,
    required this.rollNumber,
    required this.outlookEmail,
    required this.phoneNumber,
    required this.hostel,
    required this.roomNumber,
    required this.destination,
    required this.checkOutTime,
    required this.checkInTime,
    required this.isClosed,
  });

  factory EntryDetails.fromJson(Map<String, dynamic> json) {
    return EntryDetails(
      checkOutGate: json['checkOutGate'],
      checkInGate: json['checkInGate'],
      entryId: json['_id'],
      name: json['name'],
      rollNumber: json['rollNumber'],
      outlookEmail: json['outlookEmail'],
      phoneNumber: json['phoneNumber'],
      hostel: json['hostel'],
      roomNumber: json['roomNumber'],
      destination: json['destination'],
      checkOutTime: DateTime.parse(json['checkOutTime']),
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'])
          : null,
      isClosed: json['isClosed'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'checkInGate': checkInGate,
      'checkOutGate': checkOutGate,
      'entryId': entryId,
      'name': name,
      'rollNumber': rollNumber,
      'outlookEmail': outlookEmail,
      'phoneNumber': phoneNumber,
      'hostel': hostel,
      'roomNumber': roomNumber,
      'destination': destination,
      'outTime': checkOutTime.toIso8601String(),
      'inTime': checkInTime?.toIso8601String(),
      'isClosed': isClosed,
    };

    return data;
  }
}
