import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khokha_entry/src/globals/departments.dart';
import 'package:khokha_entry/src/globals/hostels.dart';
import 'package:khokha_entry/src/globals/my_colors.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/globals/prgrams.dart';
import 'package:khokha_entry/src/models/khokha_exit_model.dart';
import 'package:khokha_entry/src/models/profile_model.dart';
import 'package:khokha_entry/src/screens/khokha_entry_qr.dart';
import 'package:khokha_entry/src/utility/show_snackbar.dart';
import 'package:khokha_entry/src/utility/validity.dart';
import 'package:khokha_entry/src/widgets/custom_drop_down.dart';
import 'package:khokha_entry/src/widgets/custom_text_field.dart';
import 'package:khokha_entry/src/widgets/destination_suggestions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhokhaEntryForm extends StatefulWidget {
  static const id = "/khokha_entry_form";

  const KhokhaEntryForm({super.key});

  @override
  State<KhokhaEntryForm> createState() => _KhokhaEntryFormState();
}

class _KhokhaEntryFormState extends State<KhokhaEntryForm> {
  // form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  String? hostel;
  final List<String> hostels = khostels;
  var program = kprograms.first;
  var branch = kdepartments.first;
  var selectedDestination = "Khokha";
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

  void resetForm() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode((await prefs.getString("userInfo"))!);
    ProfileModel p = ProfileModel.fromJson(userData);
    _nameController.text = p.name;
    _rollController.text = p.rollNo;
    _phoneController.text =
        p.phoneNumber == null ? "" : p.phoneNumber.toString();
    _roomNoController.text = p.roomNo ?? "";
    _destinationController.text = "";
    _emailController.text = p.outlookEmail;
    hostel = p.hostel;
    selectedDestination = destinationSuggestions.first;
    setState(() {});
  }

  void showQRImage() async {
    if (!_formKey.currentState!.validate()) {
      showSnackBar(context, 'Please give all the inputs correctly');
      return;
    }
    final destination = selectedDestination == "Other"
        ? _destinationController.text
        : selectedDestination;
    final mapData = {
      "name": _nameController.text,
      "outlookEmail": _emailController.text,
      "rollNumber": _rollController.text,
      "phoneNumber": _phoneController.text,
      "roomNumber": _roomNoController.text,
      "hostel": hostel,
      "program": program,
      "branch": branch,
      "destination": destination,
    };
    final data = jsonEncode(mapData);
    debugPrint("Khokha Entry Data: $data");
    final model = KhoKhaExitModel.fromJson(mapData);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return KhokhaEntryQR(
          model: model,
          destination: destination,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: kBackground,
        appBar: appBar(context),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Fields marked with',
                                    style:
                                        MyFonts.w500.setColor(kWhite3).size(12),
                                  ),
                                  TextSpan(
                                    text: ' * ',
                                    style: MyFonts.w500.setColor(kRed).size(12),
                                  ),
                                  TextSpan(
                                    text: 'are compulsory',
                                    style:
                                        MyFonts.w500.setColor(kWhite3).size(12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          resetText(),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'Name',
                              // validator: validatefield,
                              isNecessary: false,
                              controller: _nameController,
                              isEnabled: false,
                            ),
                            const SizedBox(height: 12),
                            CustomDropDown(
                              value: hostel,
                              items: hostels,
                              label: 'Hostel',
                              onChanged: (h) => hostel = h,
                              validator: validatefield,
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              label: 'Outlook Email',
                              validator: validatefield,
                              isNecessary: true,
                              controller: _emailController,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 12),
                            CustomDropDown(
                              value: program,
                              items: kprograms,
                              label: 'Program',
                              onChanged: (p) => program = p,
                              validator: validatefield,
                            ),
                            const SizedBox(height: 12),
                            CustomDropDown(
                              value: branch,
                              items: kdepartments,
                              label: 'Branch',
                              onChanged: (d) => branch = d,
                              validator: validatefield,
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              label: 'Hostel room no',
                              validator: validatefield,
                              isNecessary: true,
                              controller: _roomNoController,
                              maxLength: 5,
                              maxLines: 1,
                              counter: true,
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
                              isNecessary: true,
                              controller: _rollController,
                              maxLength: 9,
                              maxLines: 1,
                              counter: true,
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
                              isNecessary: true,
                              controller: _phoneController,
                              inputType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 10,
                              maxLines: 1,
                              counter: true,
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
                                    ? validatefield
                                    : null,
                              ),
                            const SizedBox(height: 12),
                          ],
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
                            color: lBlue2,
                          ),
                          child: const Text(
                            'Generate QR',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kAppBarGrey,
      iconTheme: const IconThemeData(color: kAppBarGrey),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: kWhite,
        ),
        iconSize: 20,
      ),
      title: Text(
        "Khokha Entry",
        textAlign: TextAlign.left,
        style: MyFonts.w500.size(23).setColor(kWhite),
      ),
    );
  }

  InkWell resetText() {
    return InkWell(
      onTap: resetForm,
      child: Text(
        "Reset",
        style: MyFonts.w500.size(12).setColor(lBlue2),
        textAlign: TextAlign.end,
      ),
    );
  }
}
