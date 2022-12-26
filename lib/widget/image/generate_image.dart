
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GenerateImage extends StatefulWidget {
  const GenerateImage({Key? key, required this.urlImage}) : super(key: key);
  final String? urlImage;
  @override
  State<GenerateImage> createState() => _GenerateImageState();
}

class _GenerateImageState extends State<GenerateImage> {

  @override
  Widget build(BuildContext context) {


    return FancyShimmerImage(
      height: 150.h,
      imageUrl: widget.urlImage.toString(),
      shimmerBaseColor: Colors.white,
      shimmerHighlightColor: Colors.blue,
      shimmerBackColor: Colors.grey,
      errorWidget: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.error), Text('Image not available')],
        ),
      ),
    );


  }
}
