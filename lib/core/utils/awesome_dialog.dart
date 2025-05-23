import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

mixin AwesomeDialogMixin {
  AwesomeDialog buildSuccessDialog(
      BuildContext context,
      String title,
      String desc, {
        VoidCallback? onOk,
      }) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      borderSide: const BorderSide(color: kGreenColor, width: 1),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
      autoDismiss: onOk == null ? true : false,
      autoHide: onOk == null ? const Duration(seconds: 2) : null,
    );
  }
   showSenderSuccessDialog({
    required BuildContext context,
    required String senderName,
    required VoidCallback onOk,
     required String title,
     required String desc,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: title,
      desc: desc,
      btnOkText: "OK",
      btnOkOnPress: onOk,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOkColor: kGreenColor,
    ).show();
  }



  AwesomeDialog buildWarningDialog(
      BuildContext context, String title, Function() ok) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(color: kYellowColor, width: 1),
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: title,
      desc: 'Are you sure to $title?',
      showCloseIcon: false,
      btnCancelOnPress: () {},
      btnOkOnPress: ok,
    );
  }
   buildFailedDialog(
      BuildContext context, String title, Function() ok) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      borderSide: const BorderSide(color: kYellowColor, width: 1),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: title,
      desc: '$title?',
      showCloseIcon: false,
      btnCancelOnPress: () {},
      btnOkOnPress: ok,
    ).show();
  }
}
