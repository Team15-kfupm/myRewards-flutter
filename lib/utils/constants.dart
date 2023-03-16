import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors Section Start//

const primaryColor = Color(0xFFFEC54B);
const secondaryColor = Color(0xFFFDB244);
const authPageClipColor = Color(0xFFF2BB69);
const greyColor = Color(0xFF6A6A6A);
const lightGreyColor = Color(0xFFD9D9D9);
const whiteColor = Colors.white;
const blackColor = Colors.black;

// Colors Section End//

// Text Style Section Start//

final smallPrimaryTextStyle = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
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

final normaPrimarylTextStyle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

final expireOTPCountdownTextStyle =
    GoogleFonts.abel(fontSize: 17.sp, color: greyColor);

final forgotPasswordTextStyle =
    GoogleFonts.abel(fontSize: 17.sp, color: primaryColor);

final oTPLabelTextStyle = GoogleFonts.abel(fontSize: 28.sp, color: blackColor);

final titleTextStyle = GoogleFonts.poppins(
  fontSize: 21.sp,
  fontWeight: FontWeight.w600,
  color: blackColor,
);

// Text Style Section End//

// Button Style Section Start//

final signInButtonStyle = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(30.r),
);

ButtonStyle noBackgroundButtonStyle = TextButton.styleFrom(
  primary: whiteColor,
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