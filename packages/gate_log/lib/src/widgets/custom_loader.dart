import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: OneStopColors.primaryColor,
      ),
    );
  }
}
