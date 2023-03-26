import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

// import 'Screens/Signup and Signin/signin.dart';
// import 'Screens/Signup and Signin/signin.dart';
import 'bottomNavigationBar.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MaterialApp(
          title: 'SaleItNow',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: kWhiteColor,
            appBarTheme: AppBarTheme(
              backgroundColor: kPrimaryColor,
              // iconTheme: IconThemeData(
              //   size: 23.sp,
              //   color: kSecondaryColor,
              // ),
            ),
          ),
          home: const BottomNavigation()
          // SiginPage(),
          );
    });
  }
}
