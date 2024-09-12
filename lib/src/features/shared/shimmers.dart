import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerStrip extends StatelessWidget {
  const ShimmerStrip({
    super.key,
    required this.height,
    required this.width,
    this.radius = 3,
    this.margin,
  });

  final double height, width, radius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: margin,
        height: height,
        // width: size.width * 0.3,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
