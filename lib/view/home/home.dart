
import 'package:enam_dua_teknologi/constant/constant.dart';
import 'package:enam_dua_teknologi/controller/search.dart';
import 'package:enam_dua_teknologi/widget/default_scroll/default_scroll.dart';
import 'package:enam_dua_teknologi/widget/image/generate_image.dart';
import 'package:enam_dua_teknologi/widget/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  final SearchController controller = Get.put(SearchController());
  @override
  void initState() {
    scrollController.addListener(() { //scroll listener
        double showoffset = 10.0; //Back to top botton will show on scroll offset 10.0

        if(scrollController.offset > showoffset){
              showbtn = true;
              setState(() {
                //update state
              });
        }else{
             showbtn = false;
              setState(() {
                //update state
              });
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 15,
            backgroundColor: primaryColor,
            title: TextField(
              style: TextStyle(
                fontFamily: 'unbounded',
                fontSize: 12.sp,
                color: Colors.black
              ),
              focusNode: controller.focusNode,
              controller: controller.searchController.value,

              onChanged: controller.getData,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
                constraints: BoxConstraints(
                    maxHeight: 40.0,
                    maxWidth: Get.width),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                suffixIcon: IconButton(
                  onPressed: (() async {
                    controller.searchController.value.clear();
                    controller.listRecords.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                    controller.setSearchEmpty(true);
                    await Future.delayed(const Duration(milliseconds: 200));
                    controller.getData('');
                  }),
                  icon: Center(
                    child: controller.loading.value
                        ? CircleAvatar(
                            radius: 10.r,
                            backgroundColor: Colors.white,
                            // maxRadius: 11.r,
                            child: const CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ))
                        : const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintStyle: TextStyle(
                  fontFamily: 'unbounded',
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                focusColor: Colors.black,
              ),
              cursorColor: Colors.black,
            ),
          ),
          floatingActionButton: AnimatedOpacity(
           duration: const Duration(milliseconds: 1000),
           opacity: showbtn ? 1.0 : 0.0,
           child: FloatingActionButton(
              onPressed: () {
                 scrollController.animateTo(
                   0,
                   duration: const Duration(milliseconds: 1000),
                   curve:Curves.fastOutSlowIn
                  );
              },
              backgroundColor: Colors.red[500],
              child:  const Icon(Icons.arrow_upward, color: Colors.white,),
           ),
         ),
          body: ScrollConfiguration(
            behavior: DefaultScroll(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: SizedBox(
                  height: Get.height,
                  child: controller.listRecords.isEmpty &&
                          controller.loading.value == false &&
                          controller.searchEmpty.value
                      ? const Center(
                          child: DataNotFound(
                            message: 'Please type the text in the search box',
                          ),
                        )
                      : controller.dataNotFound.value
                          ? const Center(
                              child: DataNotFound(
                                message: 'Data not found',
                              ),
                            )
                          : AnimationLimiter(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GridView.count(
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.7,
                                  controller: scrollController,
                                  physics:
                                      const RangeMaintainingScrollPhysics(),
                                  children: List.generate(
                                    controller.listRecords.length,
                                    (int index) {
                                      var post = controller.listRecords[index];
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                  const  NeverScrollableScrollPhysics(),
                                                children: [
                                                  GestureDetector(
                                                    onTap: (() async {
                                                      FocusScope.of(context).requestFocus(FocusNode());
                                                      await Future.delayed(const Duration(milliseconds: 200));
                                                      debugPrint(
                                                          'statement ${post['id']}');
                                                      Get.toNamed('/detail',
                                                        arguments: {
                                                          'title': post['name'],
                                                          'id': post['id']
                                                        }
                                                      );
                                                    }),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                              10.r),
                                                        ),
                                                        child:
                                                            GenerateImage(
                                                              urlImage: post['image_url'],
                                                            )

                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Text(
                                                    post['name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Text(
                                                      '${post['review_count']} reviews'),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(post['rating']
                                                          .toString()),
                                                      RatingBar.builder(
                                                        itemSize: 15.0,
                                                        initialRating:
                                                            post['rating'],
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,


                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )),
            ),
          ),
        );
      },
    );
  }
}
