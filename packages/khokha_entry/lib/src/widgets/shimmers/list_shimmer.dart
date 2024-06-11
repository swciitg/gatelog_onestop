import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  late final double height;
  late final int count;
  // ignore: prefer_const_constructors_in_immutables
  ListShimmer({
    Key? key,
    this.height = 80,
    this.count = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container sample = Container(
      height: height,
      decoration: BoxDecoration(
          color: OneStopColors.kBlack, borderRadius: BorderRadius.circular(25)),
    );
    return Shimmer.fromColors(
      period: const Duration(seconds: 1),
      baseColor: OneStopColors.kShimmerBaseColor,
      highlightColor: OneStopColors.kShimmerHighlightColor,
      child: SizedBox(
        height: max(400, count * height),
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: sample,
          ),
        ),
      ),
    );
  }
}
