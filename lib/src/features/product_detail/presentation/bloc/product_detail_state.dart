part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailLoaded extends ProductDetailState {
  final ProductEntity product;

  const ProductDetailLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class ProductDetailFailure extends ProductDetailState {
  final String errorMessage;

  const ProductDetailFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
