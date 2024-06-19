import 'package:flutter/material.dart';
import 'package:gate_log/src/globals/my_fonts.dart';
import 'package:onestop_kit/onestop_kit.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          height: 1,
          color: OneStopColors.cardColor,
        ),
      ),
      backgroundColor: OneStopColors.backgroundColor,
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
        title,
        textAlign: TextAlign.left,
        style: MyFonts.w500.size(23).setColor(OneStopColors.kWhite),
      ),
    );
  }
}
