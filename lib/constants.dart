import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const Color kScaffoldColor = Color(0xFFFFFFFF);
const Color kPrimaryColor = Color(0xFF17202A);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kTextBlackColor = Color(0xFF000000);
const Color kWhiteColor = Color(0xfffdfdf5);
const Color kBlackColor = Color(0xFF000000);
const Color kSecondaryColor = Color(0xFF2196F3);
const Color kGreyColor = Color(0xFF9E9E9E);
const Color kHighlightColors = Color(0xFFF44336);
const Color kButtonColor = Color(0xFF4CAF50);
const Color kbackgroundColor = Color(0xFFD3D1D1);
const Color kFilledColor = Color(0xfff2f2f2);
final kMargin = EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h);
final kPadding = EdgeInsets.all(2.h);
final kRadius = BorderRadius.circular(2.h);

// /default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);
setupColor(BuildContext context, percentage) {
  if (percentage >= 50) {
    return kScaffoldColor;
  } else if (percentage >= 25) {
    return Colors.red;
  }
  return Colors.orange;
}
