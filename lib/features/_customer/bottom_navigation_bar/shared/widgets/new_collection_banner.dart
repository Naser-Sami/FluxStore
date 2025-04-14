import 'package:flutter/material.dart';

import '/config/_config.dart' show OnTapScaler;
import 'fashion_collection_design_banner.dart';

class NewCollectionBanner extends StatelessWidget {
  const NewCollectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return OnTapScaler(
      onTap: () {},
      child: const FashionCollectionDesignBanner(
        height: 158,
        hint: '| New Collection',
        title: 'HANG OUT\n& PARTY',
        image: 'women-feature-products-5',
      ),
    );
  }
}
