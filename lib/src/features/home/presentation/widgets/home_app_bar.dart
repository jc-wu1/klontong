import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/textfield_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required StreamController<bool> streamController,
  }) : _streamController = streamController;

  final StreamController<bool> _streamController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      pinned: true,
      backgroundColor: Colors.white,
      title: MyTextField(
        prefixIcon: const Icon(Icons.search),
        hint: 'Cari barang disini',
        onTap: () => context.pushNamed("products"),
        readOnly: true,
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: ColoredBox(
          color: primaryColor50,
        ),
      ),
      expandedHeight: kToolbarHeight + 16,
      actions: [
        StreamBuilder(
          initialData: false,
          stream: _streamController.stream,
          builder: (context, snapshot) {
            bool isScrollDown = snapshot.data ?? false;
            return IconButton(
              style: IconButton.styleFrom(
                foregroundColor: isScrollDown ? Colors.black : Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              ),
            );
          },
        ),
        StreamBuilder(
          initialData: false,
          stream: _streamController.stream,
          builder: (context, snapshot) {
            bool isScrollDown = snapshot.data ?? false;
            return IconButton(
              style: IconButton.styleFrom(
                foregroundColor: isScrollDown ? Colors.black : Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag,
              ),
            );
          },
        ),
      ],
    );
  }
}
