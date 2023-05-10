import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWudget extends StatelessWidget {
  const ShimmerWudget(
      {super.key,
      required this.width,
      required this.height,
      required this.radius,
      required this.hilighColor,
      required this.baseColor});
  final double width;
  final double height;
  final double radius;
  final Color hilighColor;
  final Color baseColor;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: hilighColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
