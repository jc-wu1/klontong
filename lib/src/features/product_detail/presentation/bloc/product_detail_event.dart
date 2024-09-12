part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailRequested extends ProductDetailEvent {
  final String productId;

  const ProductDetailRequested({required this.productId});

  @override
  List<Object> get props => [productId];
}
