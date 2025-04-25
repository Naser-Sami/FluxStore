import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetWorkImageComponent extends StatelessWidget {
  const CachedNetWorkImageComponent({
    super.key,
    required this.imageUrl,
    this.fit,
  });

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      alignment: Alignment.topCenter,
      fit: fit ?? BoxFit.cover,
      progressIndicatorBuilder:
          (context, url, downloadProgress) => const SizedBox(
            height: 20,
            width: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
