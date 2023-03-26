import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';
import '../widgets/custom_chart.dart';
import '../widgets/data/data.dart';
import '../widgets/icon_btn.dart';
import '../widgets/models/cost_model.dart';
import '../widgets/models/type_model.dart';

class ProfitabilityPage extends StatefulWidget {
  const ProfitabilityPage({super.key});

  @override
  State<ProfitabilityPage> createState() => _ProfitabilityPageState();
}

class _ProfitabilityPageState extends State<ProfitabilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
//------------------------------AppBar------------------------------------------
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 10.h,
            leading: CustomBtn(
              onPress: () {},
              iconData: Icons.settings_outlined,
              color: Colors.white,
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Profitability',
                style: GoogleFonts.aBeeZee(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: kTextWhiteColor,
                ),
              ),
            ),
            actions: [
              CustomBtn(
                onPress: () {},
                iconData: Icons.add_outlined,
                color: Colors.white,
              ),
            ],
          ),
//-------------------------Chart-Container--------------------------------------
          SliverList(
            delegate: SliverChildBuilderDelegate((context, int index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(
                    left: 2.w,
                    right: 2.w,
                    top: 2.h,
                    bottom: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(3.h),
                  ),
                  child: CustomChart(
                    expenses: weeklySpending,
                  ),
                );
              } else {
                final TypeModel typeModel = typeNames[index - 1];
                double tAmountSpent = 0;
                typeModel.expenses!.forEach((CostModel expense) {
                  tAmountSpent += expense.cost!;
                });
                return _buildCategories(typeModel, tAmountSpent);
              }
            }, childCount: 1 + typeNames.length),
          ),
        ],
      ),
    );
  }
}

_buildCategories(TypeModel category, double tAmountSpent) {
  return Container(
    width: 100.w,
    height: 13.h,
    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
    decoration: BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(2.h),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name!,
                style: GoogleFonts.abel(
                    fontSize: 14.sp,
                    color: kTextWhiteColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0),
              ),
              Text(
                category.name!,
                style: GoogleFonts.abel(
                    fontSize: 14.sp,
                    color: kTextWhiteColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
