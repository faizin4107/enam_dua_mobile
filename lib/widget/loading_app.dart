import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({Key? key,
  required this.topPaddingLoading,
  required this.color})
      : super(key: key);
  final double topPaddingLoading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPaddingLoading),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
            height: 50.h,
            width: 50.w,
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [color],
                strokeWidth: 2,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black),
          ))
        ],
      ),
    );
  }
}
