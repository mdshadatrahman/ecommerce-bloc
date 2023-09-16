part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel productDataModel;

  HomeProductWishlistButtonClickedEvent({required this.productDataModel});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel productDataModel;

  HomeProductCartButtonClickedEvent({required this.productDataModel});
}

class HomeWishlistButtonNavigationEvent extends HomeEvent {}

class HomeCartButtonNavigationEvent extends HomeEvent {}
