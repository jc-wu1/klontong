import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../products/domain/entity/product_entity.dart';
import '../../domain/usecases/product_detail_usecases.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUsecases _usecases;
  ProductDetailBloc({
    required ProductDetailUsecases usecases,
  })  : _usecases = usecases,
        super(ProductDetailInitial()) {
    on<ProductDetailRequested>(_onProductDetailRequested);
  }

  Future<void> _onProductDetailRequested(
    ProductDetailRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final result = await _usecases.getProductDetail(
        productId: event.productId,
      );
      result.fold(
        (l) => emit(ProductDetailFailure(errorMessage: l.errorMessage)),
        (r) => emit(
          ProductDetailLoaded(product: r),
        ),
      );
    } catch (e) {
      return emit(
        const ProductDetailFailure(
          errorMessage: "Terjadi kesalahan",
        ),
      );
    }
  }
}
