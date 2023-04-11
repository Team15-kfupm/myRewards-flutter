import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Firebase Options Section Start//
const apiKey = 'AIzaSyBGlVY6MQ6n6Iv2UZjq-E4PAZm5_wQCN3w';
const appId = '1:654852290280:android:a7fe0fbe3154dd9b82bb5d';
const messagingSenderId = '654852290280';
const projectId = 'myrewards-e3b0c';

// Firebase Options Section End//

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

// English regex pattern
const enPattern =
    r'Purchase \(Mada Pay\)\s+Amount: (\d+\.\d{2}) SAR\s+Mada Card: (\d{4}\*)\s+From: ([\w\s]+)\s+Date: (\d{4}-\d{2}-\d{2}) (\d{2}:\d{2})';

// r'Local Purchase\s*Card: \\\\d+;?\s(mada\s?\(Atheer\))?[\n\s]Amount:\s(\d+\.\d{2}\s*(SAR)?)\s*At:\s*([\w\s]+)[\n\s]Date:\s(\d{4}\/\d{2}\/\d{2})\s*(\d{2}:\d{2}:\d{2})';

// Arabic regex pattern
const arPattern =
    r'^شراء\s*\((مدى Pay)\)\s*مبلغ:\s*(\d+\.\d{2})\s*SAR\s*بطاقة\s*مدى:\s*(\d{4}\*)\s*من:\s*(\w+\s*\w*\s*\w*\s*\w*\s*\w*\s*\w*)\s*في:\s*(\d{4}-\d{2}-\d{2})\s*(\d{2}:\d{2})$';

//  r'(شراء|Local Purchase)(.)(بطاقة|Card):(\s)(\+\d+)(.)(مبلغ|Amount):(\s*)(\d+[\.\d]\s*SAR)(.)(لدى|At):(\s*)([\w\s]+)(.)(في|Date):(\s)([\d-]+)(\s*)([\d:]+)?';

// Regex Section End//



