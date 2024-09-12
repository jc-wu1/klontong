import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/colors.dart';
import '../../../core/injector.dart';
import '../../../core/widgets/textfield_widget.dart';
import '../../products/data/model/product_model.dart';
import 'bloc/add_product_bloc.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(
        usecases: sl(),
      ),
      child: const AddProductPageView(),
    );
  }
}

class AddProductPageView extends StatefulWidget {
  const AddProductPageView({super.key});

  @override
  State<AddProductPageView> createState() => AddProductPageViewState();
}

class AddProductPageViewState extends State<AddProductPageView> {
  late TextEditingController _categoryController;
  late TextEditingController _skuController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController();
    _skuController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _skuController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is AddProductLoading) {
        } else if (state is AddProductSuccess) {
          _onAddProductSuccess(context, state.product.id!);
        } else if (state is AddProductFailure) {
          _onAddProductFailed(context, state);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Tambahkan Produk'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kategori Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _categoryController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "Kategori produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SKU Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _skuController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "SKU produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nama Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _nameController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "Nama produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Deskripsi Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    maxLines: 4,
                    controller: _descriptionController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "Deskripsi produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Link Gambar Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _imageController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "Gambar produk tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Harga Produk',
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _priceController,
                    validator: (string) {
                      if (string == null || string == "") {
                        return "Harga tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: primaryColor50,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ProductModel payload = ProductModel(
                    categoryId: "${Random.secure().nextInt(100000) + 900000}",
                    categoryName: _categoryController.value.text,
                    sku: _skuController.value.text,
                    name: _nameController.value.text,
                    description: _descriptionController.value.text,
                    image: _imageController.value.text,
                    price: _priceController.value.text,
                    id: "${Random.secure().nextInt(100000) + 900000}",
                  );

                  BlocProvider.of<AddProductBloc>(context).add(
                    AddProductRequested(payload: payload),
                  );
                }
              },
              child: const Text(
                'Tambahkan Produk',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddProductFailed(BuildContext context, AddProductFailure state) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menambahkan produk. ${state.errorMessage}',
          ),
        ),
      );
  }

  void _onAddProductSuccess(BuildContext context, String productId) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          content: const Text('Produk berhasil ditambahkan'),
          action: SnackBarAction(
            label: "Lihat",
            onPressed: () {
              context.pushNamed(
                "productDetail",
                pathParameters: {
                  "productId": productId,
                },
              );
            },
          ),
        ),
      );
    _categoryController.clear();
    _skuController.clear();
    _nameController.clear();
    _descriptionController.clear();
    _imageController.clear();
    _priceController.clear();
  }
}
