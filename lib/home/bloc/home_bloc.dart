import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/data/cart_items.dart';
import 'package:ecommerce_bloc/data/grocery_data.dart';
import 'package:ecommerce_bloc/data/wishlist_items.dart';
import 'package:ecommerce_bloc/home/models/product_data_model.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer show log;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigationEvent>(homeWishlistButtonNavigationEvent);
    on<HomeCartButtonNavigationEvent>(homeCartButtonNavigationEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    try {
      emit(
        HomeLoadingSuccessState(
          products: GroceryData.groceryProducts
              .map((e) => ProductDataModel(
                    id: e['id'],
                    name: e['name'],
                    category: e['category'],
                    price: e['price'],
                    image: e['image'],
                  ))
              .toList(),
        ),
      );
    } catch (e) {
      developer.log('Error: $e', name: 'homeInitialEvent');
      emit(HomeErrorState());
    }
  }

  FutureOr<void> homeWishlistButtonNavigationEvent(HomeWishlistButtonNavigationEvent event, Emitter<HomeState> emit) {
    developer.log('Navigating to Wishlist Page');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigationEvent(HomeCartButtonNavigationEvent event, Emitter<HomeState> emit) {
    developer.log('Navigating to Cart Page');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishListItems.add(event.productDataModel);
    emit(ItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.productDataModel);
    emit(ItemAddedToCartActionState());
  }
}
