import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show OnTapScaler;
import '/features/_features.dart'
    show AddToCartParams, CartCubit, RemoveFromCartParams, UserSessionCubit;
import '/features/product/_product.dart' show ProductDetails;

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key, required this.product});

  final ProductDetails product;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  String userId = '';
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> _getUser() async {
    final user = await context.read<UserSessionCubit>().getUser();
    userId = user?.id ?? "";
    print('USERID: $userId');
  }

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {
        _toggleFavorite();

        if (isFavorite) {
          context.read<CartCubit>().addToCart(
            AddToCartParams(
              userId: userId,
              productId: widget.product.id,
              quantity: 1,
              // color: ,
              // size:
            ),
          );
        } else {
          context.read<CartCubit>().removeFromCart(
            RemoveFromCartParams(userId: userId, productId: widget.product.id),
          );
        }
      },
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          Icons.favorite,
          size: 16,
          color: isFavorite ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
