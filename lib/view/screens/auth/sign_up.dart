// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                "Create An Account",
                style: GoogleFonts.laila(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Already a member?",
                    style: GoogleFonts.laila(fontSize: 15, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SiginPage()));
                    },
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.laila(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FirstandLastNameField(),
              const SizedBox(height: 10),
              BusinessNameField(),
              const SizedBox(height: 10),
              EmailField(),
              const SizedBox(height: 10),
              PhoneField(),
              const SizedBox(height: 10),
              GSTNoFeild(),
              const SizedBox(height: 10),
              PasswordFeild(),
              const SizedBox(height: 10),
              ConformPasswordField(),
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
                      style:
                          GoogleFonts.laila(fontSize: 15, color: Colors.black),
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
      ),
    );
  }
}

FirstandLastNameField() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "First and Last Name",
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

BusinessNameField() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Business / Company Name",
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
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
          ),
        ),
      ),
    ],
  );
}

PhoneField() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Phone",
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    ],
  );
}

GSTNoFeild() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: "GSTIN No.",
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    ],
  );
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

ConformPasswordField() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: "ConformPassword",
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
