import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_fade/image_fade.dart';

import '../../core/utils/constants.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    super.key,
    required this.image,
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.w,
        height: 200.h,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: ImageFade(
              // whenever the image changes, it will be loaded, and then faded in:
              // image: NetworkImage('$imageUrl/$image'),
              image: image,
              // slow fade for newly loaded images:
              duration: const Duration(milliseconds: 900),

              // if the image is loaded synchronously (ex. from memory), fade in faster:
              syncDuration: const Duration(milliseconds: 150),

              // supports most properties of Image:
              alignment: Alignment.center,
              fit: BoxFit.cover,

              // shown behind everything:
              placeholder: Container(
                color: kLightGreyColor,
                alignment: Alignment.center,
                child:
                const Icon(Icons.photo, color: Colors.white70, size: 60.0),
              ),

              // shows progress while loading an image:
              loadingBuilder: (context, progress, chunkEvent) =>
                  Center(child: CircularProgressIndicator(value: progress)),

              // displayed when an error occurs:
              errorBuilder: (context, error) => Container(
                color: kMediumGreyColor,
                alignment: Alignment.center,
                child: const Icon(Icons.person,
                    color: kGreyWhiteColor, size: 50.0),
              ),
            )));
  }
}
