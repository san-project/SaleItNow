import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/admin_provider.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/providers/product_provider.dart';
import 'package:saleitnow/utils/shared_prefs.dart';
import 'package:saleitnow/view/screens/admin/home.dart';
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
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) => AdminProvider(),
        )
      ],
      child: MaterialApp(
        title: 'SaleItNow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            scaffoldBackgroundColor: kWhiteColor,
            fontFamily: GoogleFonts.poppins().fontFamily,
            primarySwatch: Colors.blueGrey),
        home: Builder(builder: (context) {
          return Sizer(builder: (context, orientation, deviceType) {
            return SharedPrefs.instance().token == null
                ? const SiginPage()
                : SharedPrefs.instance().isAdmin
                    ? const HomeScreen()
                    : const BottomNavigation();
            // SiginPage(),
          });
        }),
      ),
    );
  }
}
