// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleitnow/Screens/Signup%20and%20Signin/signup.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  // final bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
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
            EmailField(),
            const SizedBox(height: 10),
            PasswordFeild(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.laila(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Or Sign in with",
                    style: GoogleFonts.laila(fontSize: 15, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Image.asset("assets/images/facebook.png"),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Image.asset("assets/images/google.png"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

PasswordFeild() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
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
      ),
    ],
  );
}

EmailField() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
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
      ),
    ],
  );
}
