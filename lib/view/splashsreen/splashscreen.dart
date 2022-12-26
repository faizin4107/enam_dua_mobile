import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enam_dua_teknologi/constant/constant.dart';
import 'package:enam_dua_teknologi/widget/loading_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    runTiming();
    super.initState();
  }

  runTiming() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offNamedUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    const curve = Curves.easeOutQuad;
    const durationMS = 275;
    const colorizeColors = [
  Colors.white,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];
 var colorizeTextStyle = TextStyle(
  fontSize: 19.sp,
  fontFamily: 'unbounded-bold',
);

    return AnimatedContainer(
      curve: curve,
      duration: const Duration(milliseconds: durationMS),
      child: Scaffold(
        backgroundColor: primaryColor,
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Flexible(
                    flex: 0,
                    fit: FlexFit.tight,
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 360.0.w,
                              height: 50.0.h,
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'PT. Enam Dua Teknologi',
                                    textAlign: TextAlign.center,
                                    textStyle: colorizeTextStyle,
                                    colors: colorizeColors,
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                onTap: () {
                                },
                              ),),
                              SizedBox(
                                width: 360.0.w,
                                height: 50.0.h,
                                child: const LoadingApp(
                                  topPaddingLoading: 0,
                                  color: Colors.white,
                                )),
                            ],
                          )),
                        ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
