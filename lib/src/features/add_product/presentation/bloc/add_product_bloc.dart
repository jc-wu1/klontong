import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../products/data/model/product_model.dart';
import '../../../products/domain/entity/product_entity.dart';
import '../../domain/usecases/add_products_usecases.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUsecases _usecases;
  AddProductBloc({
    required AddProductUsecases usecases,
  })  : _usecases = usecases,
        super(AddProductInitial()) {
    on<AddProductRequested>(_onAddProductRequested);
  }

  Future<void> _onAddProductRequested(
    AddProductRequested event,
    Emitter<AddProductState> emit,
  ) async {
    emit(AddProductLoading());
    try {
      final result = await _usecases.addProduct(payload: event.payload);
      result.fold(
        (l) => emit(
          AddProductFailure(
            errorMessage: l.errorMessage,
          ),
        ),
        (r) => emit(
          AddProductSuccess(product: r),
        ),
      );
    } catch (e) {
      return emit(
        const AddProductFailure(
          errorMessage: "Terjadi kesalahan",
        ),
      );
    }
  }
}
