import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const Color kScaffoldColor = Color(0xFFFFFFFF);
const Color kPrimaryColor = Color(0xFF17202A);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kTextBlackColor = Color(0xFF000000);
const Color kWhiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color kBlackColor = Color(0xFF000000);
const Color kSecondaryColor = Color(0xFF2196F3);
const Color kGreyColor = Color(0xFF9E9E9E);
const Color kHighlightColors = Color(0xFFF44336);
const Color kButtonColor = Color(0xFF4CAF50);

final kMargin = EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h);
final kPadding = EdgeInsets.all(2.h);
final kRadius = BorderRadius.circular(2.h);

Color setupColor(double percentage) {
  if (percentage >= 0.50) {
    return kScaffoldColor;
  } else if (percentage >= 0.25) {
    return Colors.orange;
  }
  return Colors.red;
}
