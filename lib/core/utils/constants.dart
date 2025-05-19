import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

// ============= COLORS CONSTS ==============
const Color kLightBlueColor = Color(0xFF6589FF);
const Color kPrimaryBlueColor = Color(0xFF003AFC);
const Color kGreenColor = Color(0xFF77D16F);
const Color kYellowColor = Color(0xFFFFE120);
const Color kRedColor = Color(0xFFFA3A57);
const Color kBlackColor = Color(0xFF272727);
const Color kLightGreyColor = Color(0xFFE6E6E6);
const Color kWhiteColor = Color(0xFFFFFFFF);

const Color kGreyWhiteColor = Color(0xFF898989);
const Color kMediumGreyColor = Color(0xFFB2B2B2);
const Color kBackgroundColor = Color(0xFFF7F6FF);

const Color kDarkGreyColor = Color(0xFF7C7C7C);
TextStyle statusTextStyle = GoogleFonts.poppins(
  color: kMediumGreyColor,
  fontSize: 16,
);

const kGradient = LinearGradient(
    colors: <Color>[kLightBlueColor, kPrimaryBlueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

// ============= TEXT STYLES CONSTS ==============

TextStyle buildAppBarTextStyle(
        {Color color = kLightBlueColor,
        double fontSizeController = 18,
        double letterSpacing = 1.5}) =>
    TextStyle(
        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSizeController);
TextStyle tileTextTitleStyle = GoogleFonts.poppins(
  color: kBlackColor,
  fontSize: 20,
);

TextStyle tileTextNumberStyle = GoogleFonts.poppins(
  color: kMediumGreyColor,
  fontSize: 14,
);
TextStyle tagsTextStyle = GoogleFonts.poppins(
  color: kLightBlueColor,
  fontSize: 14,
);

// ============= TextFieldBorder ==============

OutlineInputBorder buildOutlineInputBorderTextField() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none);
}

BoxDecoration buildBoxDecoration() {
  return const BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(color: Colors.black12)));
}

TextStyle kTextFieldTextStyle = GoogleFonts.poppins(
    fontSize: 12.sp,
    letterSpacing: 0.4000000059604645,
    color: kMediumGreyColor);

// ============= ApiEndpoints ============== //

/* public */
const String baseUrl = "http://palmail.gazawar.wiki/api";
const String loginUrl = "$baseUrl/login";
const String registerUrl = "$baseUrl/register";
const String imageUrl = "http://palmail.gazawar.wiki/";

/* private */

// CURRENT USER AUTH //
const String currentUserInfoUrl = "$baseUrl/user";
const String currentUpdateUserUrl = "$currentUserInfoUrl/update";
const String logoutrUrl = "$baseUrl/logout";

// GENERAL USER AUTH //
const String allUsersUrl = "$baseUrl/users";
const String CRUD_UsersUrl = "$allUsersUrl/";
/* TODO:
here add {id}, Post for create, Get gor get,  DEL for delete,PUT for update
for change password add id /password
for change role add id /role
*/

// MAILS //
const String allMailsUrl = "$baseUrl/mails"; // also create mail
const String CRUD_mailsUrl = "$allMailsUrl/";

// CATEGORIES //
const String allCategoriesUrl = "$baseUrl/categories"; // also create category
const String categoryMailUrl =
    "$allCategoriesUrl/"; // add id for for single category , add id/mails for mails of category

// TAGS //

const String allTagsUrl = "$baseUrl/tags"; // also all tags with mails

const String allTagsOfMailUrl =
    "$allMailsUrl/"; //  add id/tags for all tags of mail

// STATUSES //
const String statusUrl = "$baseUrl/statuses";

const String fetchUrl = "$statusUrl/"; //  add id/{}?mail=true

const String allTStatusesUrl = "$statusUrl?mail=false";
const String singleStatus = "$statusUrl/"; //  add id/{}?mail=true

// ROLES //
const String allRolesUrl = "$baseUrl/roles";

// SEARCH //
const String searchUrl = "$baseUrl/search?";

// SENDERS //
const String sendersUrl = "$baseUrl/senders";
const String CRUD_senderUrl = "$sendersUrl/"; // add  id

// ATTACHMENTS //
const String allAttachmentsUrl = "$baseUrl/attachments";

// utils //
const spinkit = Center(
  child: SpinKitThreeBounce(
    color: kMediumGreyColor,
    size: 40.0,
  ),
);
const progressSpinkit = SpinKitFadingCircle(
  color: Colors.white,
  size: 30.0,
);
