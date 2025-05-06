import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_store/core/utils/extensions/hex_color.dart';

import '/config/_config.dart'
    show
        CachedNetWorkImageComponent,
        OnTapScaler,
        TPadding,
        TRadius,
        TSize,
        TextWidget;
import '/core/_core.dart'
    show
        ApiEndpoints,
        BuildContextExtensions,
        CurrencyStringExtension,
        TFunctions;
import '/features/_features.dart'
    show CartCubit, CartItem, RemoveFromCartParams, UpdateCartParams;

class CartItemsBody extends StatelessWidget {
  const CartItemsBody({super.key, required this.carts, required this.userId});

  final List<CartItem> carts;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Expanded(
      flex: 50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TPadding.p32,
          ).copyWith(bottom: TPadding.p32, top: TPadding.p24),
          child: Column(
            spacing: TSize.s24,
            children: [
              for (var i = 0; i < carts.length; i++)
                Container(
                  width: context.screenWidth,
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(TSize.s20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(
                          alpha: TFunctions.isDarkMode(context) ? 1.0 : 0.2,
                        ),
                        blurRadius: 10,
                        offset: const Offset(3, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(TSize.s20),
                            bottomStart: Radius.circular(TSize.s20),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(TSize.s20),
                            bottomStart: Radius.circular(TSize.s20),
                          ),
                          child: CachedNetWorkImageComponent(
                            imageUrl: ApiEndpoints.imageUrl + carts[i].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(TPadding.p12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    carts[i].productName,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  OnTapScaler(
                                    onTap: () {},
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        // color: colorScheme.tertiaryContainer,
                                        color: colorScheme.inverseSurface
                                            .withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(
                                          TRadius.r04,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: colorScheme.surface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextWidget(
                                carts[i].unitPrice.toString().toCurrencyString(
                                  symbol: '\$',
                                ),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        children: [
                                          const TextSpan(text: 'Price'),
                                          const TextSpan(text: ': '),
                                          TextSpan(text: carts[i].selectedSize),
                                          const TextSpan(text: ' | '),
                                          const TextSpan(text: 'Color'),
                                          const TextSpan(text: ': '),
                                          TextSpan(
                                            text:
                                                carts[i].selectedColor
                                                    ?.toColorName(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: TSize.s10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: TPadding.p08,
                                      vertical: TPadding.p01,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: colorScheme.outlineVariant,
                                        width: 1.8,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        TSize.s20,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        OnTapScaler(
                                          onTap:
                                              () => _onUpdateCart(
                                                context,
                                                userId: userId,
                                                productId: carts[i].productId,
                                                quantity: carts[i].quantity - 1,
                                              ),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                        const SizedBox(width: TSize.s10),
                                        Text(
                                          carts[i].quantity.toString(),
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: TSize.s10),
                                        OnTapScaler(
                                          onTap:
                                              () => _onUpdateCart(
                                                context,
                                                userId: userId,
                                                productId: carts[i].productId,
                                                quantity: carts[i].quantity + 1,
                                              ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onUpdateCart(
    BuildContext context, {
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    if (quantity > 0) {
      context.read<CartCubit>().updateCart(
        UpdateCartParams(
          userId: userId,
          productId: productId,
          quantity: quantity,
        ),
      );
    } else {
      context.read<CartCubit>().removeFromCart(
        RemoveFromCartParams(userId: userId, productId: productId),
      );
    }
  }
}
