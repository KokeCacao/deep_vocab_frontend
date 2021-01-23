import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double height;
  final double width;

  ImageWidget(
      {this.imageUrl: "http://via.placeholder.com/350x150",
      this.fit,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
