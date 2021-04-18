import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String image;
  final String? errorImage;
  final BoxFit? fit;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  BoxShape? shape;

  CachedImage({
    required this.image,
    this.errorImage,
    this.fit,
    this.width,
    this.height,
    this.margin,
    this.shape,
  });

  @override
  State<StatefulWidget> createState() {
    return CachedImageState();
  }
}

class CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image,
      imageBuilder: (context, image) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            shape: widget.shape ?? BoxShape.rectangle,
              image: DecorationImage(
            image: image,
            fit: widget.fit ?? BoxFit.fill,
          )),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          alignment: Alignment.center,
          child: CircularProgressIndicator(value: downloadProgress.progress),
        );
      },
      errorWidget: (context, url, error) => widget.errorImage == null ? Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        alignment: Alignment.center,
        color: Colors.white,
        child: Icon(Icons.error),
      ):Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: widget.shape ?? BoxShape.rectangle,
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(widget.errorImage!).image,
                fit: BoxFit.cover)),
        child: Container(),
      ),
    );
  }
}
