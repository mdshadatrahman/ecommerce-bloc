import 'package:ecommerce_bloc/home/models/product_data_model.dart';
import 'package:ecommerce_bloc/main.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    super.key,
    required this.product,
    required this.onAddToCartButtonClick,
    required this.onAddToWishlistButtonClick,
  });

  final ProductDataModel product;
  final VoidCallback onAddToWishlistButtonClick;
  final VoidCallback onAddToCartButtonClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white60,
            image: DecorationImage(
              image: NetworkImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            IconButton(onPressed: onAddToWishlistButtonClick, icon: const Icon(Icons.favorite_outline)),
            IconButton(onPressed: onAddToCartButtonClick, icon: const Icon(Icons.shopping_cart_outlined)),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
