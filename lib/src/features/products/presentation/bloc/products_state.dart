part of 'products_bloc.dart';

enum LoadStatus { initial, success, failure }

class ProductsState extends Equatable {
  const ProductsState({
    this.currentPage = 1,
    this.status = LoadStatus.initial,
    this.hasReachedMax = false,
    this.products = const <ProductEntity>[],
    this.query = '',
    this.msg = '',
  });

  final LoadStatus status;
  final int currentPage;
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final String query;
  final String msg;

  ProductsState copyWith({
    LoadStatus? status,
    int? currentPage,
    List<ProductEntity>? products,
    bool? hasReachedMax,
    String? query,
    String? msg,
  }) {
    return ProductsState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentPage,
        products,
        hasReachedMax,
        query,
        msg,
      ];
}
