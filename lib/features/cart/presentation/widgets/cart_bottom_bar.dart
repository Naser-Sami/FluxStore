import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize, TextWidget;
import '/core/_core.dart'
    show BuildContextExtensions, CurrencyStringExtension, TFunctions;
import '/features/cart/_cart.dart' show Cart;

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Expanded(
      flex: 50,
      child: Container(
        width: context.screenWidth,
        padding: const EdgeInsets.all(
          TPadding.p24,
        ).copyWith(bottom: TPadding.p12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(
                alpha: TFunctions.isDarkMode(context) ? 1.0 : 0.2,
              ),
              blurRadius: 10,
              offset: const Offset(3, 2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSize.s20),
            topRight: Radius.circular(TSize.s20),
          ),
          color: colorScheme.surface,
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              spacing: TSize.s16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget('Product Price', style: textTheme.bodyMedium),
                    Text(
                      cart.total.toString().toCurrencyString(symbol: '\$'),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget('Shipping', style: textTheme.bodyMedium),
                    Text(
                      cart.shippingCost == 0
                          ? 'Free shipping'
                          : cart.shippingCost.toString().toCurrencyString(
                            symbol: '\$',
                          ),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget('Subtotal', style: textTheme.titleMedium),
                    Text(
                      cart.subTotal.toString().toCurrencyString(symbol: '\$'),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed to checkout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
