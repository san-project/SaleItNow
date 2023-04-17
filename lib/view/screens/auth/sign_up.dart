// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/auth_provider.dart';
import 'sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _addressController;
  late final TextEditingController _businessNameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _gstinController;
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  late final FocusNode _confirmPasswordNode;
  late final FocusNode _addressNode;
  late final FocusNode _businessNameNode;
  late final FocusNode _mobileNode;
  late final FocusNode _gstNode;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    _addressNode = FocusNode();
    _businessNameNode = FocusNode();
    _mobileNode = FocusNode();
    _gstNode = FocusNode();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _addressController = TextEditingController();
    _businessNameController = TextEditingController();
    _mobileController = TextEditingController();
    _gstinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _addressNode.dispose();
    _businessNameNode.dispose();
    _mobileNode.dispose();
    _gstNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    _mobileController.dispose();
    _gstinController.dispose();
    super.dispose();
  }

  void signUp() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final seller = SellerModelForRegistering(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      businessName: _businessNameController.text,
      address: _addressController.text,
      gstNo: _gstinController.text,
      mobile: _mobileController.text,
    );
    context.read<AuthProvider>().signUp(seller, context);
  }

  final inputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(6));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 16),
          child: Form(
            key: _formKey,
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
                      style:
                          GoogleFonts.laila(fontSize: 15, color: Colors.black),
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
                addressField(),
                const SizedBox(height: 10),
                GSTNoFeild(),
                const SizedBox(height: 10),
                PasswordFeild(),
                const SizedBox(height: 10),
                ConformPasswordField(),
                const SizedBox(height: 10),
                SizedBox(
                  height: 12.w,
                  width: 90.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: signUp,
                    child: Consumer<AuthProvider>(
                      builder: (BuildContext context, provider, child) =>
                          provider.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "Sign Up",
                                  style: GoogleFonts.laila(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? textFiledValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field Cannot be Empty!';
    }
    return null;
  }

  FirstandLastNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _nameController,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_businessNameNode),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: textFiledValidator,
        decoration: InputDecoration(
            labelText: "First and Last Name",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  BusinessNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_emailNode),
        textInputAction: TextInputAction.next,
        focusNode: _businessNameNode,
        controller: _businessNameController,
        keyboardType: TextInputType.text,
        validator: textFiledValidator,
        decoration: InputDecoration(
            labelText: "Business / Company Name",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  addressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        focusNode: _addressNode,
        controller: _addressController,
        validator: textFiledValidator,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_gstNode),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Address",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  EmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        focusNode: _emailNode,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_mobileNode),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Enter a valid email!';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Email",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  PhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_addressNode),
        textInputAction: TextInputAction.next,
        focusNode: _mobileNode,
        controller: _mobileController,
        validator: textFiledValidator,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "Phone",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  GSTNoFeild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_passwordNode),
        textInputAction: TextInputAction.next,
        focusNode: _gstNode,
        controller: _gstinController,
        validator: textFiledValidator,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            labelText: "GSTIN No.",
            focusedBorder: inputBorder,
            border: inputBorder),
      ),
    );
  }

  PasswordFeild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        focusNode: _passwordNode,
        controller: _passwordController,
        onFieldSubmitted: (value) =>
            FocusScope.of(context).requestFocus(_confirmPasswordNode),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password cannot be empty";
          }
          if (value.length < 8) {
            return "Password cannot be less than 8 characters";
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: "Password",
          focusedBorder: inputBorder,
          border: inputBorder,
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility_off_outlined),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  ConformPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        focusNode: _confirmPasswordNode,
        validator: (value) {
          if (value != _passwordController.text) {
            return "confirm password and password didn't match";
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: "ConformPassword",
          focusedBorder: inputBorder,
          border: inputBorder,
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility_off_outlined),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
