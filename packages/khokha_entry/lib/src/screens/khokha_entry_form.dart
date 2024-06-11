import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khokha_entry/src/apis.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:khokha_entry/src/models/entry_details.dart';
import 'package:khokha_entry/src/models/exit_qr_model.dart';
import 'package:khokha_entry/src/screens/khokha_entry_qr.dart';
import 'package:khokha_entry/src/utility/validity.dart';
import 'package:khokha_entry/src/widgets/custom_drop_down.dart';
import 'package:khokha_entry/src/widgets/custom_text_field.dart';
import 'package:khokha_entry/src/widgets/destination_suggestions.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhokhaEntryForm extends StatefulWidget {
  static const id = "/khokha_entry_form";

  const KhokhaEntryForm({super.key});

  @override
  State<KhokhaEntryForm> createState() => _KhokhaEntryFormState();
}
// TODO: MAKE CODE CONCISE (FILE SIZE MUST BE < 250)
// TODO: USE ONLY CLASS BASED WIDGETS

class _KhokhaEntryFormState extends State<KhokhaEntryForm> {
  // form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  Hostel hostel = Hostel.none;
  final List<Hostel> hostels = Hostel.values;
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

  Future<void> getUserId()async{
    userId = await Apis().getUserId();
  }

  void resetForm() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode((await prefs.getString("userInfo"))!);
    var user = OneStopUser.fromJson(userData);
    _nameController.text = user.name;
    _rollController.text = user.rollNo.toString();
    _phoneController.text =
        user.phoneNumber == null ? "" : user.phoneNumber.toString();
    _roomNoController.text = user.roomNo ?? "";
    _destinationController.text = "";
    _emailController.text = user.outlookEmail;
    print("User Hostel : ${user.hostel}");
    hostel = Hostel.values
        .firstWhere((element) => element.displayString == user.hostel);
    selectedDestination = destinationSuggestions.first;
    setState(() {});
  }

  void showQRImage() async {
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
      'userId' : userId,
    };
    final data = jsonEncode(mapData);
    debugPrint("Khokha Entry Data: $data");
    final model = EntryDetails.fromJson(mapData);
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
        backgroundColor: OneStopColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: OneStopColors.secondaryColor,
          iconTheme: const IconThemeData(color: OneStopColors.secondaryColor),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: OneStopColors.kWhite,
            ),
            iconSize: 20,
          ),
          title: Text(
            "CheckOut",
            textAlign: TextAlign.left,
            style: MyFonts.w500.size(23).setColor(OneStopColors.kWhite),
          ),
        ),
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
                                    style: MyFonts.w500
                                        .setColor(OneStopColors.cardFontColor2)
                                        .size(12),
                                  ),
                                  TextSpan(
                                    text: ' * ',
                                    style: MyFonts.w500
                                        .setColor(OneStopColors.errorRed)
                                        .size(12),
                                  ),
                                  TextSpan(
                                    text: 'are compulsory',
                                    style: MyFonts.w500
                                        .setColor(OneStopColors.cardFontColor2)
                                        .size(12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: resetForm,
                            child: Text(
                              "Reset",
                              style: MyFonts.w500
                                  .size(12)
                                  .setColor(OneStopColors.primaryColor),
                              textAlign: TextAlign.end,
                            ),
                          ),
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
                              value: hostel.displayString,
                              items: Hostel.values.displayStrings(),
                              label: 'Hostel',
                              onChanged: (String h) {
                                print(h);
                                final updated = h.getHostelFromDisplayString();
                                if (updated != null) {
                                  hostel = updated;
                                }
                              },
                              validator: (String? h) {
                                if (h != null) {
                                  final updated =
                                      h.getHostelFromDisplayString();
                                  if (updated == Hostel.none) {
                                    return "Select valid hostel";
                                  } else {
                                    return null;
                                  }
                                }
                                return "Select valid hostel";
                              },
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              label: 'Outlook Email',
                              validator: validateField,
                              isNecessary: true,
                              controller: _emailController,
                              maxLines: 1,
                              isEnabled: false,
                            ),
                            const SizedBox(height: 12),
                            // CustomDropDown(
                            //   value: Program.none.displayString,
                            //   items: Program.values.displayStrings(),
                            //   label: 'Program',
                            //   onChanged: (String p) {
                            //     final updated = p.getProgramFromDisplayString();
                            //     if (updated != null) {
                            //       program = updated;
                            //     }
                            //   },
                            //   validator: (String? p) {
                            //     if (p != null) {
                            //       final updated =
                            //           p.getProgramFromDisplayString();
                            //       if (updated == Program.none) {
                            //         return "Select valid program";
                            //       } else {
                            //         return null;
                            //       }
                            //     }
                            //     return "Select valid program";
                            //   },
                            // ),
                            // const SizedBox(height: 12),
                            // CustomDropDown(
                            //   value: Branch.none.displayString,
                            //   items: Branch.values.displayStrings(),
                            //   label: 'Branch',
                            //   onChanged: (String d) {
                            //     final updated = d.getBranchFromDisplayString();
                            //     if (updated != null) {
                            //       branch = updated;
                            //     }
                            //   },
                            //   validator: (String? b) {
                            //     print(b.runtimeType);
                            //     print(b);
                            //     if (b != null) {
                            //       final updated =
                            //           b.getBranchFromDisplayString();
                            //       if ((program == Program.bDes ||
                            //               program == Program.mDes) &&
                            //           updated != Branch.dod) {
                            //         return "Select valid branch";
                            //       }
                            //       if (updated == Branch.none) {
                            //         return "Select valid branch";
                            //       } else {
                            //         return null;
                            //       }
                            //     }
                            //     return "Select valid branch";
                            //   },
                            // ),
                            // const SizedBox(height: 12),
                            CustomTextField(
                              label: 'Hostel room no',
                              validator: validateField,
                              isNecessary: true,
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
                              isNecessary: true,
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
                              isNecessary: true,
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
}
