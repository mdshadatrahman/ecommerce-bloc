part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  HomeLoadingSuccessState({required this.products});

  final List<ProductDataModel> products;
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class ItemWishlistedActionState extends HomeActionState {}

class ItemAddedToCartActionState extends HomeActionState {}
