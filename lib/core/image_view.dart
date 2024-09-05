import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(this.url,
      {Key? key,
      this.placeholder,
      this.height = 100,
      this.width = 100,
      this.fit,
      this.alignment = Alignment.center})
      : super(key: key);
  final String? url;
  final Widget? placeholder;
  final double height;
  final double width;
  final BoxFit? fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    Widget placeholderWidget = placeholder ?? AppPlaceholderWidget.image;
    if (url != null && url!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url!,
        errorWidget: (context, url, error) => placeholderWidget,
      );
    }
    return placeholderWidget;
  }
}

class AppSvgAsset extends StatelessWidget {
  const AppSvgAsset(
    this.asset, {
    Key? key,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);
  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (asset.isEmpty) {
      return AppPlaceholderWidget.image;
    }
    return SvgPicture.asset(
      asset,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      color: color,
    );
  }
}

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.asset, {
    Key? key,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);
  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
    );
  }
}

class AppPlaceholderWidget {
  static get image => const AppSvgAsset(
        'assets/images/no_image.svg',
        fit: BoxFit.cover,
      );
}

class AppCircleImage extends StatelessWidget {
  const AppCircleImage(this.url, {Key? key, this.size = 50.0})
      : super(key: key);

  final String url;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: AppNetworkImage(
            url,
            height: size,
            width: size,
          )),
    );
  }
}

class AppCustomCirleProfileIamge extends StatelessWidget {
  final bool isStringImag;
  final String? imagePath;
  final Uint8List? memoryImage;
  final double radius;
  const AppCustomCirleProfileIamge({super.key,  this.isStringImag=true,  this.imagePath, this.memoryImage,this.radius=25});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
  radius: radius,
  backgroundImage:(isStringImag!=true && memoryImage?.isNotEmpty==true && memoryImage!=null)
      ? MemoryImage(memoryImage!)
      :imagePath!=null?NetworkImage(imagePath!):null, // Set backgroundImage to null if avatar is empty
  child: memoryImage?.isEmpty==true &&isStringImag==false
      ? ClipOval(
          child: Image.asset(
            "assets/images/empty_small_image.png",
            fit: BoxFit.cover,
            width: 30.0,  // Set the size manually
            height: 30.0,
          ),
        )
      : isStringImag &&imagePath==null?ClipOval(
          child: Image.asset(
            "assets/images/empty_small_image.png",
            fit: BoxFit.cover,
            width: 30.0,  // Set the size manually
            height: 30.0,
          ),
        ):null, )// Show image if avatar is not empty
;
  }
}