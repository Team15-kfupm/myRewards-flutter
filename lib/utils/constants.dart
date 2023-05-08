import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
const lineChartAreaColor = Color(0xFFEBF3FF);
const secondlineChartAreaColor = Color(0xFFEEf5FF);
const brightCoffeShopLegendColor = Color(0xFFFFC165);
const darkCoffeShopLegendColor = Color(0xFFFFAA7E);
const brightRestuarantLegendColor = Color(0xFFC53172);
const darkRestuarantLegendColor = Color(0xFFA671CA);
const darkTravelLegendColor = Color(0xFFB778FF);
const brightTravelLegendColor = Color(0xFF33CBFA);
const brightEntertainmentLegendColor = Color(0xFF9CF5C6);
const darkEntertainmentLegendColor = Color(0xFF54E1c3);
const brightShoppingLegendColor = Color(0xFF5DF377);
const darkShoppingLegendColor = Color(0xFF329D95);
const brightOtherLegendColor = Color(0xFFD2ADE2);
const darkOtherLegendColor = Color(0xFFF770A2);

// Colors Section End//

// LinearGradient Section Start//
const coffeShopLegendGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[darkCoffeShopLegendColor, brightCoffeShopLegendColor]);

const restaurantLegendGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[darkRestuarantLegendColor, brightRestuarantLegendColor]);

const travelLegendGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[darkTravelLegendColor, brightTravelLegendColor]);

const entertainmentLegendGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[
      darkEntertainmentLegendColor,
      brightEntertainmentLegendColor
    ]);

const shoppingLegendGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: <Color>[darkShoppingLegendColor, brightShoppingLegendColor]);

const otherLegendGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[darkOtherLegendColor, brightOtherLegendColor]);

const unSelectedLegendGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[greyColor, lightGreyColor]);

var donutChartcolors = {
  "cafe": coffeShopLegendGradient,
  "restaurant": restaurantLegendGradient,
  "shopping": shoppingLegendGradient,
  "entertainment": entertainmentLegendGradient,
  "travel": travelLegendGradient,
  "other": otherLegendGradient,
};

// LinearGradient Section End//

// Text Style Section Start//

final statTotalSpendingsLabelTextStyle = GoogleFonts.poppins(
  fontSize: 18.spMin,
  fontWeight: FontWeight.w400,
  color: profileTileValueColor,
);

final statTotalSpendingsTextStyle = GoogleFonts.poppins(
  fontSize: 24.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final statXAxisLableTextStyle = GoogleFonts.poppins(
  fontSize: 15.spMin,
  fontWeight: FontWeight.w500,
  color: profileTileValueColor,
);
final statCategoryLabelTextStyle = GoogleFonts.poppins(
  fontSize: 16.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final statSeeAllTextStyle = GoogleFonts.poppins(
  fontSize: 16.spMin,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);
final statCategoryPercentageTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w400,
  color: blackColor,
);

final statCategoryTypeTextStyle = GoogleFonts.poppins(
  fontSize: 16.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final donutTotalSpendingsAmountTextStyle = GoogleFonts.poppins(
  fontSize: 30.spMin,
  fontWeight: FontWeight.w600,
  color: settingsTileTitleColor,
);

final donutTotalSpendingsLabelTextStyle = GoogleFonts.poppins(
  fontSize: 14.spMin,
  fontWeight: FontWeight.w400,
  color: profileTileValueColor,
);

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

final xAxisLabelTextStyle = GoogleFonts.poppins(
  fontSize: 15.spMin,
  fontWeight: FontWeight.w400,
  color: profileTileValueColor,
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

final offerTitleTextStyle = GoogleFonts.poppins(
  fontSize: 20.spMin,
  fontWeight: FontWeight.w500,
  color: settingsTileTitleColor,
);

final offerPointsTextStyle = GoogleFonts.poppins(
  fontSize: 16.spMin,
  fontWeight: FontWeight.w400,
  color: settingsTileTitleColor,
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
    r'(\d+\.\d+|\d+)!(?:From|from|at|At)\W+([^!]+)!(?:On|Date|on|date)\W+(\S+\s+\S+)';

const arPattern =
    r'(\d*\.\d*|\d+)!(?:من|اسم المتجر)\W+([^!]+)!(?:في|بتاريخ)\W+(\S+\s+\S+)';

const storeLinepattern = r'\bat\b|\bAt\b|\bfrom\b|\bFrom\b';
const amountLinePattern = r'\bamount\b|\bAmount\b';
const dateLinePattern = r'\bDate\b|\bdate\b|\bon\b|\bOn\b|\bبتاريخ\b|\bفي\b';


// Regex Section End//



