import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saleitnow/constants.dart';
import 'package:sizer/sizer.dart';

import 'sub_screens/new_product.dart';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({
    super.key,
  });

  @override
  State<AddNewProductPage> createState() => _AddNewProductPage();
}

class _AddNewProductPage extends State<AddNewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // foregroundColor: kPrimaryColor,
        title: Text(
          "Added Products",
          style: GoogleFonts.laila(
            color: kTextWhiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewProductPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
