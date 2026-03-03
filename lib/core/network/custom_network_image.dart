import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  const CustomNetworkImage({super.key, required this.url, this.width, this.height, this.fit, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(imageUrl: url, placeholder: (context, url) => CupertinoActivityIndicator(), width: width, height: height, fit: fit, errorWidget: (context, url, error) => Icon(Icons.error), fadeInDuration: Duration(seconds: 1)),
    );
  }
}
