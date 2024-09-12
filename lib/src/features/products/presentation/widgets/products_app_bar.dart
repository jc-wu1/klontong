import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/textfield_widget.dart';

class ProductsAppBar extends StatelessWidget {
  const ProductsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      pinned: true,
      backgroundColor: whiteColor10,
      title: const MyTextField(
        prefixIcon: Icon(Icons.search),
        hint: 'Cari barang disini',
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: ColoredBox(
          color: primaryColor50,
        ),
      ),
      expandedHeight: kToolbarHeight + 16,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_bag,
          ),
        ),
      ],
    );
  }
}
