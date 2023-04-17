// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/seller_provider.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import '../../utils/dummy_data.dart';
import '../../data/models/type_model.dart';
import '../widgets/custom_chart.dart';
import '../widgets/icon_btn.dart';

class ProfitabilityPage extends StatefulWidget {
  const ProfitabilityPage({super.key});

  @override
  State<ProfitabilityPage> createState() => _ProfitabilityPageState();
}

class _ProfitabilityPageState extends State<ProfitabilityPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SellerProvider>().getAllOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashbaord'),
      ),
      body: Consumer<SellerProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return LoadingWidget();
          }
          return Column(
            children: [Text(provider.listOfOrders.length.toString())],
          );
        },
      ),
//       body: CustomScrollView(
//         slivers: [
// //------------------------------AppBar------------------------------------------
//           const SliverAppBar(
//             forceElevated: true,
//             floating: true,
//             title: Text('DashBoard'),
//             // expandedHeight: 10.h,

//             // leading: CustomBtn(
//             //   onPress: () {},
//             //   iconData: Icons.settings_outlined,
//             //   color: Colors.white,
//             // // ),
//             // flexibleSpace: FlexibleSpaceBar(
//             //   title: Text(
//             //     'Profitability',
//             //     // style: GoogleFonts.laila(
//             //     //   fontSize: 15.sp,
//             //     //   fontWeight: FontWeight.w500,
//             //     //   color: kTextWhiteColor,
//             //     // ),
//             //   ),
//             // ),
//           ),
// //-------------------------Chart-Container--------------------------------------
//           SliverList(
//             delegate: SliverChildBuilderDelegate((context, int index) {
//               if (index == 0) {
//                 return Container(
//                   margin: EdgeInsets.only(
//                     left: 2.w,
//                     right: 2.w,
//                     top: 2.h,
//                     bottom: 2.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.circular(3.h),
//                   ),
//                   child: CustomChart(
//                     expenses: weeklyselling,
//                   ),
//                 );
//               } else {
//                 final TypeModel typeModel = typeNames[index - 1];
//                 double tAmountSpent = 0;
//                 for (var expense in typeModel.expenses!) {
//                   tAmountSpent += expense.cost!;
//                 }
//                 return _buildCategories(typeModel, tAmountSpent);
//               }
//             }, childCount: 1 + typeNames.length),
//           ),
//         ],
//       ),
    );
  }
}

_buildCategories(TypeModel category, double tAmountSpent) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 100.w,
      height: 13.h,
      margin: kMargin,
      padding: kPadding,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: kRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name!,
                style: GoogleFonts.abel(
                  fontSize: 14.sp,
                  color: kTextWhiteColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                '\$${(category.maxAmount! - tAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount!.toStringAsFixed(2)}',
                style: GoogleFonts.atma(
                  fontSize: 14.sp,
                  color: kTextWhiteColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          LayoutBuilder(builder: (context, constraints) {
            final double maxBarWidth = constraints.maxWidth;
            final double percentage =
                (category.maxAmount! - tAmountSpent) / category.maxAmount!;
            double width = percentage * maxBarWidth;
            if (width < 0) {
              width = 0;
            }
            return Stack(
              children: [
                Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.h),
                      bottomRight: Radius.circular(2.h),
                    ),
                  ),
                ),
                Container(
                  height: 3.h,
                  width: width,
                  decoration: BoxDecoration(
                    color: setupColor(context, percentage),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.h),
                      bottomRight: Radius.circular(2.h),
                    ),
                  ),
                ),
              ],
            );
          })
        ],
      ),
    ),
  );
}
