import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/image_provider.dart';
import './providers/admin_provider.dart';
import './providers/auth_provider.dart';
import './providers/product_provider.dart';
import './providers/seller_provider.dart';
import './utils/shared_prefs.dart';
import './view/screens/admin/home.dart';
import 'package:sizer/sizer.dart';
import 'bottom_navigation_bar.dart';
import 'constants.dart';
import './view/screens/auth/sign_in.dart';

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
        ),
        ChangeNotifierProvider<SellerProvider>(
          create: (context) => SellerProvider(),
        ),
        ChangeNotifierProvider<ProductImageProvider>(
          create: (context) => ProductImageProvider(),
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
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelAlignment: FloatingLabelAlignment.start,
            filled: true,
            fillColor: kFilledColor,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
          scaffoldBackgroundColor: kWhiteColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.blueGrey,
        ),
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
