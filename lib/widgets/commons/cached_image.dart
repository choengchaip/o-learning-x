import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String image;
  final String? errorImage;
  final BoxFit? fit;

  CachedImage({
    required this.image,
    this.errorImage,
    this.fit,
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
          decoration: BoxDecoration(
              image: DecorationImage(
            image: image,
            fit: widget.fit ?? BoxFit.fill,
          )),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(value: downloadProgress.progress),
        );
      },
      errorWidget: (context, url, error) => widget.errorImage == null ? Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Icon(Icons.error),
      ):Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(widget.errorImage!).image,
                fit: BoxFit.cover)),
        child: Container(),
      ),
    );
  }
}
