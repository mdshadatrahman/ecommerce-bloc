part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadingSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoadingSuccessState({required this.cartItems});
}

class CartErrorState extends CartState {}
