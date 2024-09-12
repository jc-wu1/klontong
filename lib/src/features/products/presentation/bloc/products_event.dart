part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductsEvent {
  const LoadProducts({
    this.page,
    this.limit,
    this.query,
  });

  final int? page, limit;
  final String? query;

  @override
  List<Object> get props => [
        page!,
        limit!,
        query!,
      ];
}

class SearchProduct extends ProductsEvent {
  const SearchProduct({
    this.page,
    this.limit,
    this.query,
  });

  final int? page, limit;
  final String? query;

  @override
  List<Object> get props => [
        page!,
        limit!,
        query!,
      ];
}
