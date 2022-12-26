import 'package:enam_dua_teknologi/constant/constant.dart';
import 'package:enam_dua_teknologi/controller/detail.dart';
import 'package:enam_dua_teknologi/helper/helper.dart';
import 'package:enam_dua_teknologi/widget/default_scroll/default_scroll.dart';
import 'package:enam_dua_teknologi/widget/loading_app.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  PageController pageController = PageController(keepPage: true);
  // ignore: prefer_typing_uninitialized_variables
  var title;
  // ignore: prefer_typing_uninitialized_variables
  var id;
  final DetailController controller = Get.put(DetailController());
  @override
  void initState() {
    pageController = PageController(keepPage: true);
    setState(() {
      title = Get.arguments['title'];
      id = Get.arguments['id'];
    });

    controller.getData(id);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          title.toString(),
          style:
              GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: ScrollConfiguration(
        behavior: DefaultScroll(),
        child:
        AnimationLimiter(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: controller.obx(
                (data) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 13.01),
                          child: SizedBox(
                            width: Get.width,
                            height: 241.0.h,
                            child:
                            controller.listPhotos.isEmpty ?
                            Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.error, color: Colors.red),
                                          SizedBox(height: 4.h,),
                                          Text('Image not available',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                            :
                             PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              controller: pageController,
                              itemCount: controller.listPhotos.length,
                              itemBuilder: (_, index) {
                                var post = controller.listPhotos[index];
                                debugPrint('post $post');


                                return
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0.r),
                                      ),
                                      child: FancyShimmerImage(
                                        height: 190.h,
                                        imageUrl: '$post',
                                        shimmerBaseColor: Colors.white,
                                        shimmerHighlightColor: Colors.blue,
                                        shimmerBackColor: Colors.grey,
                                        errorWidget: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.error),
                                              Text('Image not available',
                                                style: TextStyle(
                                                  color: Colors.black
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              },
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: controller.status.isLoading
                            ? Container()
                            : controller.listPhotos.length < 2
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 15.54),
                                    child: SmoothPageIndicator(
                                        controller:
                                            pageController, // PageController
                                        count: controller.listPhotos.length,
                                        effect: const ExpandingDotsEffect(
                                          dotHeight: 7.0,
                                          dotWidth: 10.0,
                                          dotColor: Colors.grey,
                                          activeDotColor: Colors.blue,
                                        ), // your preferred effect
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (index) {})),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 10.0, right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0.r)),
                              border: Border.all(
                                  width: 0.5, color: const Color(0xFFD1D1D1)),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppBar(
                                  // shape: RoundedRectangleBorder(
                                  //   side: BorderSide.none,
                                  //   borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(10.0.r),
                                  //       topRight: Radius.circular(10.0.r)),
                                  // ),
                                  toolbarHeight: 76.0,
                                  elevation: 0.5,
                                  title: Column(
                                    children: [
                                      Text(
                                        controller.listRecords[0]['review_count']
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'unbounded',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(height: 4.56.h),
                                      Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontFamily: 'unbounded',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.white,
                                  centerTitle: true,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50.h,
                                        width: 360.w,
                                        decoration: BoxDecoration(

                                            // borderRadius:
                                            //         BorderRadius.all(Radius.circular(0.0.r)),
                                            border: Border.all(
                                                width: 0.0,
                                                color: const Color(0xFFD1D1D1)),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            controller.listRecords[0]['rating'] ==
                                                    null
                                                ? Text('0.0',
                                                    style: TextStyle(
                                                      fontFamily: 'unbounded',
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                    ))
                                                : Text(
                                                    controller.listRecords[0]
                                                            ['rating']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'unbounded',
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                             RatingBar.builder(
                                                    itemSize: 15.0,
                                                    initialRating: controller
                                                        .listRecords[0]['rating'],
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,

                                                    // itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                    },
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 50.h,
                                        width: 360.w,
                                        decoration: BoxDecoration(

                                            // borderRadius:
                                            //         BorderRadius.all(Radius.circular(0.0.r)),
                                            border: Border.all(
                                                width: 0.0,
                                                color: const Color(0xFFD1D1D1)),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.listRecords[0]
                                                          ['price'] ==
                                                      null
                                                  ? 'Price not available'
                                                  : controller.listRecords[0]
                                                          ['price']
                                                      .toString(),
                                              style: TextStyle(
                                                fontFamily: 'unbounded',
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 12.0, right: 12.0),
                        child: ExpansionTileCard(
                          initialElevation: 0.0,
                          elevation: 4.0,
                          trailing: Icon(Icons.expand_more,
                              color: Colors.grey, size: 25.sp),
                          duration: const Duration(milliseconds: 500),
                          animateTrailing: true,
                          baseColor: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0.r),
                          ),
                          key: cardA,
                          title: Text('Hours',
                            style: TextStyle(
                                          fontFamily: 'unbounded',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                          ),
                          subtitle:
                              Text(controller.openNow.value ? 'Open' : 'Close',
                                style: GoogleFonts.roboto(),
                              ),
                          children: <Widget>[
                            const Divider(
                              thickness: 1.0,
                              height: 1.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Column(
                                  children: List.generate(
                                      controller.listOpenHours.length, (index) {
                                    var post = controller.listOpenHours[index];
                                    return Transform.translate(
                                      offset: const Offset(-22, 0),
                                      child: Column(
                                        children: [
                                          BootstrapRow(
                                            height: 20,
                                            children: <BootstrapCol>[
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text('Overnight',
                                                   style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                  )),
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text(
                                                      post['is_overnight'] == false
                                                          ? 'No'
                                                          : 'Yes',
                                                          style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                          )),
                                            ],
                                          ),
                                          BootstrapRow(
                                            height: 20,
                                            children: <BootstrapCol>[
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text('Start',
                                                    style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                  )),
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text(
                                                      formatTimeCustom(post['start'].toString()),
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                      )),
                                            ],
                                          ),
                                          BootstrapRow(
                                            height: 20,
                                            children: <BootstrapCol>[
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text('End',
                                                    style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                  )),
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child:
                                                      Text(formatTimeCustom(post['end'].toString()),
                                                        style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                      )),
                                            ],
                                          ),
                                          BootstrapRow(
                                            height: 20,
                                            children: <BootstrapCol>[
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text('Day',
                                                    style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                  )),
                                              BootstrapCol(
                                                  sizes: 'col-6',
                                                  child: Text(
                                                    getNameDay(post['day']),
                                                      style: GoogleFonts.roboto(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                    )

                                                  ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                onLoading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    LoadingApp(
                      topPaddingLoading: 300,
                      color: Colors.red,
                    ),
                  ],
                ),
                onEmpty: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13.01),
                      child: Container(
                          width: Get.width,
                          height: 151.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                            color: const Color(0xFFF7F7F7),
                          ),
                          child: Text(controller.messageEmpty.value.toString())),
                    ),
                  ],
                ),
                onError: (error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13.23),
                        child: Container(
                            width: Get.width,
                            height: 102.65.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              color: const Color(0xFFF7F7F7),
                            ),
                            child: Text(controller.messageError.value)),
                      ),
                    ],
                  );
                })
                  ),
                ),
              );
            },
          ),
        ),

      ),
    );
  }
}
