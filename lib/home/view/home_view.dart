import 'package:ecommerce_bloc/cart/view/cart_view.dart';
import 'package:ecommerce_bloc/home/bloc/home_bloc.dart';
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
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CartView()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WishListView()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.indigo)));

          case HomeLoadingSuccessState:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Groceryyy'),
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
