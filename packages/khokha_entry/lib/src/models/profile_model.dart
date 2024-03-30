class ProfileModel {
  final String name;
  final String rollNo;
  final String outlookEmail;
  final String? altEmail;
  final int? phoneNumber;
  final int? emergencyPhoneNumber;
  final String? gender;
  final String? roomNo;
  final String? homeAddress;
  final String? dob;
  final String? hostel;
  final String? linkedin;
  final String? image;

  ProfileModel({
    required this.name,
    required this.rollNo,
    required this.outlookEmail,
    this.altEmail,
    this.phoneNumber,
    this.emergencyPhoneNumber,
    this.gender,
    this.roomNo,
    this.homeAddress,
    this.dob,
    this.hostel,
    this.linkedin,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      rollNo: json['rollNo'],
      outlookEmail: json['outlookEmail'],
      altEmail: json['altEmail'],
      phoneNumber: json['phoneNumber'],
      emergencyPhoneNumber: json['emergencyPhoneNumber'],
      gender: json['gender'],
      roomNo: json['roomNo'],
      homeAddress: json['homeAddress'],
      dob: json['dob'],
      hostel: json['hostel'],
      linkedin: json['linkedin'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rollNo': rollNo,
      'outlookEmail': outlookEmail,
      'altEmail': altEmail,
      'phoneNumber': phoneNumber,
      'emergencyPhoneNumber': emergencyPhoneNumber,
      'gender': gender,
      'roomNo': roomNo,
      'homeAddress': homeAddress,
      'dob': dob,
      'hostel': hostel,
      'linkedin': linkedin,
      'image': image,
    };
  }
}
