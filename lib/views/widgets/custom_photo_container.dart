import 'package:pailmail/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_fade/image_fade.dart';
import 'package:popup_banner/popup_banner.dart';

class CustomPhotoContainer extends StatelessWidget {
  const CustomPhotoContainer({
    super.key,
    required this.raduis,
    required this.url,
  });
  final double raduis;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PopupBanner(
                context: context,
                images: [url],
                useDots: false,
                onClick: (index) {},
                fit: BoxFit.cover)
            .show();
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: raduis,
        height: raduis,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ImageFade(
// whenever the image changes, it will be loaded, and then faded in:
// image: NetworkImage('$imageUrl/$image'),
          image: NetworkImage(url),
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
            child: const Icon(Icons.photo, color: Colors.white70, size: 36.0),
          ),

// shows progress while loading an image:
          loadingBuilder: (context, progress, chunkEvent) =>
              Center(child: CircularProgressIndicator(value: progress,color: kBackgroundColor,)),

// displayed when an error occurs:
          errorBuilder: (context, error) => Container(
            color: kMediumGreyColor,
            alignment: Alignment.center,
            child: const Icon(Icons.person, color: kGreyWhiteColor, size: 36.0),
          ),
        ),
      ),
    );
  }
}
