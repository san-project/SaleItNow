// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/repos/auth_repo.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:sizer/sizer.dart';

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
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              Text(
                "Let's sign you in.",
                style: GoogleFonts.laila(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "WelCome Back.",
                    style: GoogleFonts.laila(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "You've been missed!",
                    style: GoogleFonts.laila(fontSize: 20, color: Colors.black),
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
                    style: GoogleFonts.laila(fontSize: 15, color: Colors.black),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    context.read<AuthProvider>().signIn(
                        _emailController.text, _passwordController.text);
                    // AuthRepo().signIn(
                    //     email: _emailController.text,
                    //     password: _passwordController.text);
                  },
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
            ],
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
