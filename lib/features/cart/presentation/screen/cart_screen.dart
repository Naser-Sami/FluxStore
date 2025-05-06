import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart'
    show OnTapScaler, TPadding, TRadius, TSize, TextWidget;
import '/core/_core.dart'
    show
        BuildContextExtensions,
        CurrencyStringExtension,
        LocaleKeys,
        TFunctions;
import '/features/_features.dart'
    show MainAppBar, OnDrawerTapCubit, UserSessionCubit;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  static const String name = 'Cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onMenuPressed: () => _toggleDrawer(context),
        title: const TextWidget(LocaleKeys.Cart_cart),
      ),
      body: const Column(
        children: [Expanded(flex: 50, child: CartItemsBody()), CartBottomBar()],
      ),
    );
  }

  void _toggleDrawer(BuildContext context) {
    context.read<OnDrawerTapCubit>().toggleDrawer();
  }
}

class CartItemsBody extends StatefulWidget {
  const CartItemsBody({super.key});

  @override
  State<CartItemsBody> createState() => _CartItemsBodyState();
}

class _CartItemsBodyState extends State<CartItemsBody> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final user = await context.read<UserSessionCubit>().getUser();
    print('user id = ${user?.id}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TPadding.p32,
        ).copyWith(bottom: TPadding.p32, top: TPadding.p24),
        child: Column(
          spacing: TSize.s24,
          children: [
            for (var i = 0; i < 10; i++)
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(TPadding.p12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  'Product Name',
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
                              80.toString().toCurrencyString(symbol: '\$'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        const TextSpan(text: 'L'),
                                        const TextSpan(text: ' | '),
                                        const TextSpan(text: 'Color'),
                                        const TextSpan(text: ': '),
                                        const TextSpan(text: 'White'),
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
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: TSize.s10),
                                      Text(
                                        '1',
                                        style: textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(width: TSize.s10),
                                      OnTapScaler(
                                        onTap: () {},
                                        child: const Icon(Icons.add, size: 16),
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
    );
  }
}

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({super.key});

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
                      100.toString().toCurrencyString(symbol: '\$'),
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
                      'Free shipping',
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
                      100.toString().toCurrencyString(symbol: '\$'),
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
