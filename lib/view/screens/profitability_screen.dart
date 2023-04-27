// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:saleitnow/providers/seller_provider.dart';
import 'package:saleitnow/view/screens/orders_screen.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';
// import 'package:sizer/sizer.dart';
// import '../../constants.dart';
// import '../../data/models/type_model.dart';

class ProfitabilityPage extends StatefulWidget {
  const ProfitabilityPage({super.key});

  @override
  State<ProfitabilityPage> createState() => _ProfitabilityPageState();
}

class _ProfitabilityPageState extends State<ProfitabilityPage> {
  int touchedIndex = -1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<SellerProvider>().getAllOrders();
      context.read<SellerProvider>().getDashboardDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final radius = 120.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashbaord'),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<SellerProvider>().getDashboardDetails(),
        child: Consumer<SellerProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading || provider.dashboard == null) {
              return const LoadingWidget();
            }
            return ListView(
              children: [
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrdersScreen(),
                          ),
                        );
                      },
                      child: _buildGridTile('Total Orders',
                          provider.dashboard!.allOrders.toString()),
                    ),
                    _buildGridTile('Delivered Orders',
                        provider.dashboard!.deliveredOrders.toString()),
                    _buildGridTile('Canceled Orders',
                        provider.dashboard!.cancelledOrders.toString()),
                  ],
                ),
                Text(
                  'Your Products',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Indicator(
                      color: Colors.blue,
                      text: 'Appliances',
                      isSquare: false,
                      size: touchedIndex == 0 ? 18 : 16,
                      textColor: touchedIndex == 0
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    ),
                    Indicator(
                      color: Colors.yellow,
                      text: 'Clothing',
                      isSquare: false,
                      size: touchedIndex == 1 ? 18 : 16,
                      textColor: touchedIndex == 1
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    ),
                    Indicator(
                      color: Colors.greenAccent,
                      text: 'Electronics',
                      isSquare: false,
                      size: touchedIndex == 2 ? 18 : 16,
                      textColor: touchedIndex == 2
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Indicator(
                      color: Colors.pinkAccent[700]!,
                      text: 'Health And Beauty',
                      isSquare: false,
                      size: touchedIndex == 3 ? 18 : 16,
                      textColor: touchedIndex == 3
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    ),
                    Indicator(
                      color: Colors.purple,
                      text: 'Home Appliances',
                      isSquare: false,
                      size: touchedIndex == 3 ? 18 : 16,
                      textColor: touchedIndex == 3
                          ? AppColors.mainTextColor1
                          : AppColors.mainTextColor3,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                // Expanded(
                //     child: AspectRatio(
                //   aspectRatio: 1.3,
                //   child: PieChart(
                //     PieChartData(
                //       sections: [
                // PieChartSectionData(
                //   value: provider.dashboard!.productsMap.appliances
                //       .toDouble(),
                // ),
                // PieChartSectionData(
                //   value: provider.dashboard!.productsMap.clothing
                //       .toDouble(),
                // ),
                // PieChartSectionData(
                //   value: provider.dashboard!.productsMap.electronics
                //       .toDouble(),
                // ),
                // PieChartSectionData(
                //   value: provider.dashboard!.productsMap.healthAndBeauty
                //       .toDouble(),
                // ),
                // PieChartSectionData(
                //   value:
                //       provider.dashboard!.productsMap.home.toDouble(),
                // ),
                //       ],
                //     ),
                //   ),
                // ))
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      // pieTouchData: PieTouchData(
                      //   touchCallback:
                      //       (FlTouchEvent event, pieTouchResponse) {
                      //     setState(() {
                      //       if (!event.isInterestedForInteractions ||
                      //           pieTouchResponse == null ||
                      //           pieTouchResponse.touchedSection == null) {
                      //         touchedIndex = -1;
                      //         return;
                      //       }
                      //       touchedIndex = pieTouchResponse
                      //           .touchedSection!.touchedSectionIndex;
                      //     });
                      //   },
                      // ),

                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: [
                        PieChartSectionData(
                            radius: radius,
                            value: provider.dashboard!.productsMap.appliances
                                .toDouble(),
                            color: Colors.blue),
                        PieChartSectionData(
                            radius: radius,
                            value: provider.dashboard!.productsMap.clothing
                                .toDouble(),
                            color: Colors.yellow),
                        PieChartSectionData(
                            radius: radius,
                            value: provider.dashboard!.productsMap.electronics
                                .toDouble(),
                            color: Colors.greenAccent),
                        PieChartSectionData(
                            radius: radius,
                            value: provider
                                .dashboard!.productsMap.healthAndBeauty
                                .toDouble(),
                            color: Colors.pinkAccent[700]),
                        PieChartSectionData(
                            radius: radius,
                            value:
                                provider.dashboard!.productsMap.home.toDouble(),
                            color: Colors.purple),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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

  Card _buildGridTile(String text, String unit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              Text(unit),
            ],
          ),
        ),
      ),
    );
  }
}

// _buildCategories(TypeModel category, double tAmountSpent) {
//   return GestureDetector(
//     onTap: () {},
//     child: Container(
//       width: 100.w,
//       height: 13.h,
//       margin: kMargin,
//       padding: kPadding,
//       decoration: BoxDecoration(
//         color: kPrimaryColor,
//         borderRadius: kRadius,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 category.name!,
//                 style: GoogleFonts.abel(
//                   fontSize: 14.sp,
//                   color: kTextWhiteColor,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 1.0,
//                 ),
//               ),
//               Text(
//                 '\$${(category.maxAmount! - tAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount!.toStringAsFixed(2)}',
//                 style: GoogleFonts.atma(
//                   fontSize: 14.sp,
//                   color: kTextWhiteColor,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 1.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 2.h,
//           ),
//           LayoutBuilder(builder: (context, constraints) {
//             final double maxBarWidth = constraints.maxWidth;
//             final double percentage =
//                 (category.maxAmount! - tAmountSpent) / category.maxAmount!;
//             double width = percentage * maxBarWidth;
//             if (width < 0) {
//               width = 0;
//             }
//             return Stack(
//               children: [
//                 Container(
//                   height: 3.h,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[500],
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(2.h),
//                       bottomRight: Radius.circular(2.h),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 3.h,
//                   width: width,
//                   decoration: BoxDecoration(
//                     color: setupColor(context, percentage),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(2.h),
//                       bottomRight: Radius.circular(2.h),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           })
//         ],
//       ),
//     ),
//   );
// }

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
        )
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
