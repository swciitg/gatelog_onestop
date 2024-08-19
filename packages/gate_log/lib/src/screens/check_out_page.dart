import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gate_log/src/models/check_out_qr_data.dart';
import 'package:gate_log/src/screens/scan_qr_page.dart';
import 'package:gate_log/src/services/api.dart';
import 'package:gate_log/src/utility/validity.dart';
import 'package:gate_log/src/widgets/checkOutPage/custom_text_field.dart';
import 'package:gate_log/src/widgets/checkOutPage/destination_suggestions.dart';
import 'package:gate_log/src/widgets/custom_app_bar.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _hostelController = TextEditingController();

  var selectedDestination = "Khokha";
  var userId = '';
  final destinationSuggestions = [
    "Khokha",
    "City",
    "Other",
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    resetForm();
  }

  Future<void> getUserId() async {
    userId = await APIService().getUserId();
    print(userId);
  }

  void resetForm() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode((await prefs.getString("userInfo"))!);
    final user = OneStopUser.fromJson(userData);
    _nameController.text = user.name;
    _rollController.text = user.rollNo.toString();
    _phoneController.text = user.phoneNumber.toString();
    _roomNoController.text = user.roomNo.toString();
    _destinationController.text = "";
    _emailController.text = user.outlookEmail;
    print("User Hostel : ${user.hostel}");
    _hostelController.text = Hostel.values
        .firstWhere((element) => element.databaseString == user.hostel)
        .displayString;
    selectedDestination = destinationSuggestions.first;
    setState(() {});
  }

  void showQRImage() async {
    final nav = Navigator.of(context);
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please give all the inputs correctly')));
      return;
    }
    final destination = selectedDestination == "Other"
        ? _destinationController.text
        : selectedDestination;
    await getUserId();
    final mapData = {
      "destination": destination,
      'userId': userId,
    };
    final data = jsonEncode(mapData);
    debugPrint("Khokha Entry Data: $data");
    final model = CheckOutQrData.fromJson(mapData);
    nav.push(MaterialPageRoute(
      builder: (context) => ScanQrPage(
        qrData: model,
        destination: destination,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: OneStopColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CustomAppBar(
            title: 'CheckOut',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Name',
                            isNecessary: false,
                            controller: _nameController,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Hostel',
                            isNecessary: false,
                            controller: _hostelController,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Outlook Email',
                            validator: validateField,
                            isNecessary: false,
                            controller: _emailController,
                            maxLines: 1,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Hostel room no',
                            validator: validateField,
                            isNecessary: false,
                            controller: _roomNoController,
                            maxLength: 5,
                            maxLines: 1,
                            counter: true,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Roll Number',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              } else if (value.length != 9) {
                                return 'Enter valid roll number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            isNecessary: false,
                            controller: _rollController,
                            maxLength: 9,
                            maxLines: 1,
                            counter: true,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: 'Phone Number',
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              } else if (value.length != 10) {
                                return 'Enter valid 10 digit phone number';
                              }
                              return null;
                            },
                            isNecessary: false,
                            controller: _phoneController,
                            inputType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            maxLength: 10,
                            maxLines: 1,
                            counter: true,
                            isEnabled: false,
                          ),
                          const SizedBox(height: 12),
                          DestinationSuggestions(
                            onChanged: (val) {
                              setState(() {
                                selectedDestination = val;
                              });
                            },
                            selectedDestination: selectedDestination,
                            destinationSuggestions: destinationSuggestions,
                          ),
                          if (selectedDestination == "Other")
                            CustomTextField(
                              label: 'Destination',
                              isNecessary: true,
                              controller: _destinationController,
                              maxLength: 50,
                              counter: true,
                              validator: selectedDestination == "Other"
                                  ? validateField
                                  : null,
                            ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: showQRImage,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: OneStopColors.primaryColor,
                  ),
                  child: const Text(
                    'Generate QR',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
