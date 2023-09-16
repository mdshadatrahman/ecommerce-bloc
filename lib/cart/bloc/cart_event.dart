part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class BackButtonPressEvent extends CartEvent {}
