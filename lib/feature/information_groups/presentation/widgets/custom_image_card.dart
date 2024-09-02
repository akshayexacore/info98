import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customImageCard extends StatelessWidget {
  final double? height;final double? width;final String imageUrl;final int? index;final int imageCount;final Function? onImageTap;
  const customImageCard({
    super.key, this.height, this.width, this. index,required this.imageUrl, this.imageCount=0, this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
        
          SizedBox(
            height:height?? 107.h,
            width:width?? 170.w,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child; // Image is fully loaded
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      }
    },
            ),
          ),
         if(index==2 && imageCount>2==true)   InkWell(onTap: (){
            if(onImageTap!=null){onImageTap!();}
            },
           child: Container(
                 height:height?? 100.h,
              width:width?? 170.w,
                 color: Color.fromARGB(121, 0, 0, 0), child: Center(child: Text("${(imageCount-1).toString()}+",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.sp),),),// Black transparent overlay
               ),
         ),
        ],
      ),
    );
  }
}
