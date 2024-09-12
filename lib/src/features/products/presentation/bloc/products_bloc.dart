import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/usecases/products_usecases.dart';

part 'products_event.dart';
part 'products_state.dart';

const throttleDuration = Duration(seconds: 1);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUsecases _usecases;

  ProductsBloc({required ProductsUsecases usecases})
      : _usecases = usecases,
        super(const ProductsState()) {
    on<LoadProducts>(
      _onLoadProducts,
      transformer: throttleDroppable(
        throttleDuration,
      ),
    );
    on<SearchProduct>(
      _onSearchedAgain,
    );
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == LoadStatus.initial) {
        final products = await _usecases.getProducts(
          page: state.currentPage,
          query: event.query,
        );
        products.fold(
          (l) {
            print(l.errorMessage.toString());
            return emit(
              state.copyWith(
                status: LoadStatus.failure,
                query: event.query,
                msg: l.errorMessage,
              ),
            );
          },
          (r) {
            print(r.products!.length.toString());
            return emit(
              state.copyWith(
                status: LoadStatus.success,
                products: List.of(state.products)..addAll(r.products!),
                hasReachedMax: false,
                currentPage: state.currentPage + 1,
                query: event.query,
              ),
            );
          },
        );
      } else {
        final products = await _usecases.getProducts(
          page: state.currentPage,
          query: event.query,
        );
        products.fold(
          (l) {
            print(l.errorMessage.toString());
            return emit(
              state.copyWith(
                status: LoadStatus.success,
                hasReachedMax: true,
                products: state.products,
                query: event.query,
                msg: l.errorMessage,
              ),
            );
          },
          (r) {
            print(r.products!.length.toString());
            return emit(
              r.products?.isEmpty ?? true
                  ? state.copyWith(
                      hasReachedMax: true,
                      query: event.query,
                    )
                  : state.copyWith(
                      status: LoadStatus.success,
                      products: List.of(state.products)..addAll(r.products!),
                      hasReachedMax: false,
                      currentPage: state.currentPage + 1,
                      query: event.query,
                    ),
            );
          },
        );
      }
    } catch (e, st) {
      print(e.toString());
      print(st.toString());
      return emit(
        state.copyWith(
          status: LoadStatus.failure,
          msg: e.toString(),
          hasReachedMax: true,
          products: state.products,
          query: event.query,
        ),
      );
    }
  }

  Future<void> _onSearchedAgain(
    SearchProduct event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LoadStatus.initial,
        hasReachedMax: false,
        msg: '',
        products: [],
        currentPage: 1,
        query: event.query,
      ),
    );
    try {
      final products = await _usecases.getProducts(
        page: state.currentPage,
        query: event.query,
      );
      products.fold(
        (l) {
          return emit(
            state.copyWith(
              status: LoadStatus.success,
              // msg: l.message,
              hasReachedMax: false,
              products: state.products,
              query: event.query,
            ),
          );
        },
        (r) {
          return emit(
            r.products?.isEmpty ?? true
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: LoadStatus.success,
                    products: List.of(state.products)..addAll(r.products!),
                    hasReachedMax: false,
                    currentPage: state.currentPage + 1,
                    query: event.query,
                  ),
          );
        },
      );
    } catch (e) {
      return emit(
        state.copyWith(
          status: LoadStatus.failure,
          msg: e.toString(),
          hasReachedMax: false,
          products: state.products,
          query: event.query,
        ),
      );
    }
  }
}
