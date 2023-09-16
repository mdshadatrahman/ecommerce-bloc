import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/data/cart_items.dart';
import 'package:ecommerce_bloc/home/models/product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    try {
      emit(CartLoadingSuccessState(cartItems: cartItems));
    } catch (e) {
      emit(CartErrorState());
    }
  }
}
