import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../shared/shimmers.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      childCount: 10,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      itemBuilder: (context, index) {
        return const ShimmerStrip(
          height: 200,
          width: 150,
        );
      },
    );
  }
}
