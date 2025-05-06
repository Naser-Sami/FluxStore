import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart' show TextWidget;
import '/core/_core.dart' show LocaleKeys;
import '/features/_features.dart'
    show MainAppBar, OnDrawerTapCubit, UserEntity, UserSessionCubit;
import '/features/cart/_cart.dart'
    show Cart, CartBottomBar, CartCubit, CartItemsBody;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  static const String name = 'Cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    _getCart();
  }

  Future<UserEntity?> _getUser() async {
    return await context.read<UserSessionCubit>().getUser();
  }

  Future<void> _getCart() async {
    final user = await _getUser();
    userId = user?.id ?? '';

    if (user != null) {
      if (mounted) {
        await context.read<CartCubit>().getCart(user.id);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onMenuPressed: () => _toggleDrawer(context),
        title: const TextWidget(LocaleKeys.Cart_cart),
      ),
      body: BlocBuilder<CartCubit, Cart>(
        builder: (context, state) {
          return Column(
            children: [
              CartItemsBody(carts: state.items, userId: userId),
              CartBottomBar(cart: state),
            ],
          );
        },
      ),
    );
  }

  void _toggleDrawer(BuildContext context) {
    context.read<OnDrawerTapCubit>().toggleDrawer();
  }
}
