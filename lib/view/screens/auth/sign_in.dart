// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/utils/enums.dart';
import 'package:saleitnow/view/screens/admin/home.dart';
import 'package:saleitnow/view/screens/seller_not_apprved_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../bottom_navigation_bar.dart';
import 'sign_up.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  // final bool _isObscure = true;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (kDebugMode) {
      _emailController.text = "nikhil1@gmail.com";
      _passwordController.text = "12345678";
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Sale It Now",
                  style: GoogleFonts.laila(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 5.h),
                const Text(
                  "Let's sign you in.",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Text(
                      "WelCome Back.",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "You've been missed!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                emailField(),
                const SizedBox(height: 10),
                passwordFeild(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Passord?",
                        style: GoogleFonts.laila(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          GoogleFonts.laila(fontSize: 15, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.laila(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 100.w,
                  height: 12.w,
                  child: Consumer<AuthProvider>(
                    builder: (context, provider, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: provider.isLoading
                          ? () {}
                          : () {
                              final isValid = _formKey.currentState!.validate();
                              if (!isValid) {
                                return;
                              }
                              provider
                                  .signIn(_emailController.text,
                                      _passwordController.text, context)
                                  .then((userType) {
                                if (userType == null) {
                                  // showMessageDialog(
                                  //     context, 'Something Went Wrong');
                                } else {
                                  switch (userType) {
                                    case UserType.approvedSeller:
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const BottomNavigation(),
                                          ));
                                      break;
                                    case UserType.notApprovedSeller:
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const SellerNotApprovedScreen(),
                                          ));
                                      break;
                                    case UserType.admin:
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const HomeScreen(),
                                          ));
                                      break;
                                  }
                                }
                              });
                            },
                      child: Visibility(
                        visible: !provider.isLoading,
                        replacement: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.laila(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  passwordFeild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password Cannot be Empty';
          }
          if (value.length < 8) {
            return 'Password shouble be more than 8 letter';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Password",
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility_off_outlined),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _emailController,
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Enter a valid email!';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: const Icon(
            (Icons.email_outlined),
          ),
        ),
      ),
    );
  }
}
