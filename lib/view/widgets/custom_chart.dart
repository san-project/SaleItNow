import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import 'icon_btn.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({Key? key, required this.expenses}) : super(key: key);
  final List<double> expenses;
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    for (var price in expenses) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    }
    return Padding(
      padding: EdgeInsets.all(1.w),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: GoogleFonts.abel(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: kTextWhiteColor,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBtn(
                onPress: () {},
                iconData: Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              Text(
                'March 18, 2023 - March 15, 2023',
                style: GoogleFonts.atma(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: kTextWhiteColor),
              ),
              CustomBtn(
                onPress: () {},
                iconData: Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomBar(
                  day: 'Su',
                  amountSpent: expenses[0],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'Mo',
                  amountSpent: expenses[1],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'Tu',
                  amountSpent: expenses[2],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'We',
                  amountSpent: expenses[3],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'Th',
                  amountSpent: expenses[4],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'Fr',
                  amountSpent: expenses[5],
                  expensive: mostExpensive),
              CustomBar(
                  day: 'Sa',
                  amountSpent: expenses[6],
                  expensive: mostExpensive),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomBar extends StatelessWidget {
  CustomBar(
      {Key? key,
      required this.day,
      required this.amountSpent,
      required this.expensive})
      : super(key: key);
  final String day;
  final double amountSpent;
  final double expensive;
  final double _maxBarHeight = 20.h;
  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / expensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: GoogleFonts.aubrey(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: kTextWhiteColor),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: barHeight,
          width: 3.w,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(1.h),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          day,
          style: GoogleFonts.abel(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: kTextWhiteColor),
        ),
      ],
    );
  }
}
