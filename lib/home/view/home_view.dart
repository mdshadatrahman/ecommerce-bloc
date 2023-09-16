import 'package:ecommerce_bloc/cart/view/cart_view.dart';
import 'package:ecommerce_bloc/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc/home/view/components/product_tile_widget.dart';
import 'package:ecommerce_bloc/main.dart';
import 'package:ecommerce_bloc/wishlist/view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CartView()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WishListView()));
        } else if (state is ItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item added to cart'),
              showCloseIcon: true,
            ),
          );
        } else if (state is ItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item added to wishlist'),
              showCloseIcon: true,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.indigo)));

          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Groceryyy'),
                backgroundColor: Colors.teal,
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigationEvent());
                    },
                    icon: const Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigationEvent());
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: SizedBox(
                height: height,
                width: width,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: successState.products.length,
                      itemBuilder: (context, index) {
                        return ProductTileWidget(
                          product: successState.products[index],
                          onAddToCartButtonClick: () {
                            homeBloc.add(
                              HomeProductCartButtonClickedEvent(
                                productDataModel: successState.products[index],
                              ),
                            );
                          },
                          onAddToWishlistButtonClick: () {
                            homeBloc.add(
                              HomeProductWishlistButtonClickedEvent(
                                productDataModel: successState.products[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error occured',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
