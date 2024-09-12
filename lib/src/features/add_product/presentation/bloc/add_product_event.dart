part of 'add_product_bloc.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductRequested extends AddProductEvent {
  final ProductModel payload;

  const AddProductRequested({required this.payload});

  @override
  List<Object> get props => [payload];
}
