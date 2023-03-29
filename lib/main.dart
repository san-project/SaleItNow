import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/utils/shared_prefs.dart';

import 'package:sizer/sizer.dart';

import 'bottom_navigation_bar.dart';
import 'constants.dart';
import 'view/screens/auth/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SaleItNow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kWhiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kPrimaryColor,
            // iconTheme: IconThemeData(
            //   size: 23.sp,
            //   color: kSecondaryColor,
            // ),
          ),
        ),
        home: Sizer(builder: (context, orientation, deviceType) {
          return SharedPrefs.instance().token == null
              ? const SiginPage()
              : const BottomNavigation();
          // SiginPage(),
        }),
      ),
    );
  }
}
