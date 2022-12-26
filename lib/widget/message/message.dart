
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyState extends StatelessWidget {
  final String? title, message;
  const EmptyState({Key? key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 16,
          color: Theme.of(context).cardColor.withOpacity(.95),
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.5),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$title',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.sp,
                  )
                ),
               SizedBox(
              height: 4.h,
            ),
            Text(
              message.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.sp,
                  )
            ),

              ],
            ),
          ),
        ));
  }
}

class DataNotFound extends StatelessWidget {
  final String? message;
  const DataNotFound({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.info, color: Colors.blue,),
            SizedBox(
              height: 4.h,
            ),
            Text(
              message.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12.sp,
                  )
            ),

          ],
        );
  }
}

class FailedRequest extends StatelessWidget {
  final String? message;
  const FailedRequest({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.info, color: Colors.blue,),
            SizedBox(
              height: 4.h,
            ),
            Text(
              message.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 12.sp,
                  )
            ),
          ],
        ));
  }
}
