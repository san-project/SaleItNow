// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/constants.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/view/screens/auth/sign_in.dart';
import 'package:sizer/sizer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar theme for tablet
      appBar: AppBar(
        title: Text(
          'My Account',
          style: GoogleFonts.aBeeZee(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: kTextWhiteColor,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.report_gmailerrorred_outlined),
          ),
          IconButton(
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Log Out'),
                  content: Text('Are you sure you want to log out ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('No')),
                  ],
                ),
              );

              log("=================Log OUt $shouldLogout");
              if ((shouldLogout ?? false) && mounted) {
                context.read<AuthProvider>().logOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SiginPage(),
                      ),
                      (route) => false);
                });
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 15.h,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: SizerUtil.deviceType == DeviceType.tablet
                          ? 12.w
                          : 13.w,
                      backgroundColor: kbackgroundColor,
                      backgroundImage: AssetImage('assets/images/google.png'),
                    ),
                    kWidthSizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jhonwick',
                          style: GoogleFonts.laila(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: kTextWhiteColor,
                          ),
                        ),
                        Text(
                          'SAN.store',
                          style: GoogleFonts.laila(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: kTextWhiteColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            sizedBox,
            ProfileDetailColumn(
              title: 'Email',
              value: 'SaleItNow.san@gmail.com',
            ),
            ProfileDetailColumn(
              title: 'Business Name',
              value: 'San.store',
            ),
            ProfileDetailColumn(
              title: 'Address',
              value: 'XYZ Chock',
            ),
            ProfileDetailColumn(
              title: 'Phone Number',
              value: '+923066666666',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.abel(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: kTextBlackColor,
              ),
            ),
            kHalfSizedBox,
            Text(
              value,
              style: GoogleFonts.laila(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: kTextBlackColor,
              ),
            ),
            kHalfSizedBox,
            SizedBox(
              width: 92.w,
              child: Divider(
                thickness: 1.0,
              ),
            )
          ],
        ),
        Icon(
          Icons.lock_outline,
          size: 10.sp,
        ),
      ],
    );
  }
}
