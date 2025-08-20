import 'package:cached_network_image/cached_network_image.dart';
import 'package:chemical_compounds/core/constants/app_assets.dart';
import 'package:chemical_compounds/features/widgets/asset_image_view.dart';
import 'package:flutter/material.dart';

class NetworkImageView extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;

  final double? width;
  final double? height;
  final Alignment alignment;

  const NetworkImageView(
    this.imageUrl, {
    this.fit,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      alignment: alignment,
      fit: fit,
      placeholder: (BuildContext context, String url) {
        return Container();
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return const AssetImageView(
          fileName: Assets.productPlaceHolder,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
