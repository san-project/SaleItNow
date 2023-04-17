// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/constants.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/providers/seller_provider.dart';
import 'package:saleitnow/view/screens/auth/sign_in.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SellerProvider>().getSellerDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(),
              );
            },
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
      body: Consumer<SellerProvider>(builder: (_, sellerProvider, __) {
        final sellerDetails = sellerProvider.seller;
        if (sellerProvider.isLoading || sellerDetails == null) {
          return LoadingWidget();
        } else {
          final seller = sellerDetails;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 15.h,
                  decoration: const BoxDecoration(
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
                              : 10.w,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            seller.name[0].toUpperCase(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 22.sp),
                          ),
                        ),
                        kWidthSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              seller.name.toUpperCase(),
                              style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              seller.businessName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
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
                  value: seller.email,
                ),
                ProfileDetailColumn(
                  title: 'Business Name',
                  value: seller.businessName,
                ),
                ProfileDetailColumn(
                  title: 'Address',
                  value: seller.address,
                ),
                ProfileDetailColumn(
                  title: 'Phone Number',
                  value: seller.mobile,
                ),
              ],
            ),
          );
        }
      }),
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
