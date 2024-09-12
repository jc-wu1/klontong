import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/textfield_widget.dart';
import '../bloc/products_bloc.dart';

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
      title: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return MyTextField(
            prefixIcon: const Icon(Icons.search),
            hint: 'Cari barang disini',
            onFieldSubmitted: (String query) {
              if (query != "" && query.isNotEmpty) {
                BlocProvider.of<ProductsBloc>(context).add(
                  SearchProduct(
                    page: state.currentPage,
                    query: query,
                  ),
                );
              }
            },
          );
        },
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
