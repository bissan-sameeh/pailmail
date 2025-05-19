import 'package:flutter/material.dart';

class CustomProfilePhotoContainer extends StatelessWidget {
  final String image;
  final double raduis;

  const CustomProfilePhotoContainer({
    super.key,
    required this.raduis,
    required this.image,
  });
//
  @override
  Widget build(BuildContext context) {
    return Container(
      width: raduis,
      height: raduis,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image,),
        ),
      ),
    );
  }
}
