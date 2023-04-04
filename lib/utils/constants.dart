import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors Section Start//

const primaryColor = Color(0xFFFEC54B);
const secondaryColor = Color(0xFFFDB244);
const authPageClipColor = Color(0xFFF2BB69);
const shapesInCardBackgroundColor = Color(0xFFFFB519);
const greyColor = Color(0xFF6A6A6A);
const lightGreyColor = Color(0xFFD9D9D9);
const offerCardprimaryColor = Color(0xFFDDA85C);
const offerCardClaimBackgroundColor = Color(0xFF389AD4);
const whiteColor = Color(0xFFFFFFFF);
const blackColor = Colors.black;
const transparentColor = Colors.transparent;
const settingsAppBarIconBackgroundColor = Color(0xFFF4F4F4);
const userAvatarBackgroundColor = Color(0xFFE3E3E4);
const settingsTileIconColor = Color(0xFFA2A2A7);
const settingsTileTitleColor = Color(0xFF1E1E2D);
const settingsTileArrowIconColor = Color(0xFF7E848D);
const profileTileValueColor = Color(0xFFA2A2A7);
const welcomeTextColor = Color(0xFF7E848D);
var firstShimmerColor = Colors.grey.shade200;
var secondShimmerColor = Colors.grey.shade400;

// Colors Section End//

// Text Style Section Start//

final smallPrimaryTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);

final normaPrimarylTextStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

final smallTextStyle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: blackColor,
);

final normaGreylTextStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: greyColor,
);

final totalSpendingsAmountTextStyle = GoogleFonts.poppins(
  fontSize: 32.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final totalSpendingsTextStyle = GoogleFonts.poppins(
  fontSize: 16.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final expireOTPCountdownTextStyle =
    GoogleFonts.abel(fontSize: 17.sp, color: greyColor);

final forgotPasswordTextStyle =
    GoogleFonts.abel(fontSize: 17.sp, color: primaryColor);

final oTPLabelTextStyle = GoogleFonts.abel(fontSize: 28.sp, color: blackColor);

final titleTextStyle = GoogleFonts.poppins(
  fontSize: 20.spMin,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

final welcomeTextStyle = GoogleFonts.poppins(
  fontSize: 12.spMin,
  fontWeight: FontWeight.w400,
  color: welcomeTextColor,
);

final welcomeNameTextStyle = GoogleFonts.poppins(
  fontSize: 18.spMin,
  fontWeight: FontWeight.w600,
  color: settingsTileTitleColor,
);

final storePointsTextStyle = GoogleFonts.poppins(
  fontSize: 17.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final settingsUsernameTextStyle = GoogleFonts.poppins(
  fontSize: 17.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final settingsSectionTitleTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileIconColor,
);

final settingsTileTitleTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w400,
  color: settingsTileTitleColor,
);

final profileTileValueTextStyle = GoogleFonts.poppins(
  fontSize: 12.spMin,
  fontWeight: FontWeight.w400,
  color: profileTileValueColor,
);

final profileSelectedGenderTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w400,
  color: whiteColor,
);

final profileUnSelectedGenderTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w400,
  color: blackColor,
);

final joinedTextStyle = GoogleFonts.poppins(
  fontSize: 12.spMin,
  fontWeight: FontWeight.w400,
  color: profileTileValueColor,
);

final joinedDateTextStyle = GoogleFonts.poppins(
  fontSize: 13.spMin,
  fontWeight: FontWeight.w400,
  color: settingsTileArrowIconColor,
);

// Text Style Section End//

// Button Style Section Start//

final signInButtonStyle = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(30.r),
);

ButtonStyle noBackgroundButtonStyle = TextButton.styleFrom(
  foregroundColor: whiteColor,
);

// Button Style Section End//

// Text in Button Style Section Start//
final signInButtonTextStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

final largeButtonTextStyle =
    GoogleFonts.abel(fontSize: 25.sp, color: whiteColor);

// Text in Button Style Section End//

// Text in Radio Button Style Section Start//

// Text in Radio Button Style Section End//

// Container Style Section Start//

// Container Style Section End//

// Regex Section Start//
var phoneNumberRegex = RegExp(r'^(05)+(\d{8})$');

// Regex Section End//

