import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:onestop_kit/onestop_kit.dart';

class GuestRestrictAccess extends StatelessWidget {
  const GuestRestrictAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Not Accessible in Guest Mode",
          style: MyFonts.w400.setColor(OneStopColors.kWhite),
        ),
      ),
    );
  }
}
