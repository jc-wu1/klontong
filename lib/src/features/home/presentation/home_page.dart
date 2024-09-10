import 'package:flutter/material.dart';
import 'package:klontong/src/core/widgets/textfield_widget.dart';

import '../../../core/design_system/design_system.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: primaryColor50,
    //     foregroundColor: Colors.white,
    //     title: const MyTextField(),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: const Icon(Icons.add),
    //   ),
    // );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: whiteColor10,
            // foregroundColor: Colors.white,
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (c, ind) => const ListTile(
                title: Text('Asdkj'),
              ),
              childCount: 1000,
            ),
          )
        ],
      ),
    );
  }
}
