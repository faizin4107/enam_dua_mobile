import 'package:enam_dua_teknologi/binding/detail.dart';
import 'package:enam_dua_teknologi/binding/initalization_binding.dart';
import 'package:enam_dua_teknologi/view/detail/detail.dart';
import 'package:enam_dua_teknologi/view/home/home.dart';
import 'package:enam_dua_teknologi/view/splashsreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enam Dua Teknologi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 731),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (child, myWidget) {
          return GetMaterialApp(
            builder: (context, myWidget) {
              // myWidget = EasyLoading.init()(context, myWidget);

              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: myWidget!,
              );
            },
            theme: ThemeData(
              colorScheme: const ColorScheme.light(),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            title: 'Enam Dua Teknologi',
            debugShowCheckedModeBanner: false,
            initialRoute: '/splashscreen',
            defaultTransition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(
              milliseconds: 350,
            ),
            initialBinding: InitializationBinding(),
            getPages: [
              GetPage(
                name: '/splashscreen',
                page: (() => const SplashScreen()),
              ),
              GetPage(
                name: '/home',
                page: (() => const Home()),
              ),
              GetPage(
                name: '/detail',
                page: (() => const Detail()),
                binding: DetailBinding(),
              )
            ],
          );
        });
  }
}
