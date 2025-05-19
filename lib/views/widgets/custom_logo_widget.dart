import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/images/logo.png'),
          height: 100.h,
          width: 100.w,
        ),
        DefaultTextStyle(
          style: GoogleFonts.arefRuqaa(fontSize: 28, color: Colors.white),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('ديوان رئيس الوزراء'),
            ],
            isRepeatingAnimation: false,
          ),
        ),
      ],
    );
  }
}
