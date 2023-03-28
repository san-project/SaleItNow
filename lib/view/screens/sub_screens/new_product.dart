// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../Add_product_screen.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formField = GlobalKey<FormState>();
  late final TextEditingController productName;
  late final TextEditingController descriptionText;
  late final TextEditingController price;
  late final TextEditingController quntity;
  // late final TextEditingController CategoryBox;
  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    super.initState();
    productName = TextEditingController();
    descriptionText = TextEditingController();
    price = TextEditingController();
    quntity = TextEditingController();
  }

  @override
  void dispose() {
    productName.dispose();
    descriptionText.dispose();
    price.dispose();
    quntity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Products",
          style: GoogleFonts.abel(
            color: kTextWhiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 4.h,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              children: [
//---------------------------Add-image------------------------------------------
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    // margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 20.h,
                    width: 370.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_outlined,
                            color: Colors.black,
                            size: 4.h,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Selete Product Image",
                            style: GoogleFonts.abel(
                              color: kTextBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 2.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//---------------------------Product-Name---------------------------------------

                SizedBox(height: 1.5.h),

                TextFormField(
                  controller: productName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    labelStyle: GoogleFonts.abel(
                      fontSize: 2.h,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryColor, width: 0.5.w),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Name";
                    }
                    return null;
                  },
                ),
                // ProductName(productName),
                SizedBox(height: 1.5.h),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: GoogleFonts.abel(
                      fontSize: 2.h,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryColor, width: 0.5.w),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                  maxLines: 6,
                  minLines: 3,
                ),
                // DescriptionField(descriptionText),
                SizedBox(height: 1.5.h),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: GoogleFonts.abel(
                      fontSize: 2.h,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryColor, width: 0.5.w),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Price";
                    }
                    return null;
                  },
                ),
                // PriceField(price),
                SizedBox(height: 1.5.h),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quntity",
                    labelStyle: GoogleFonts.abel(
                      fontSize: 2.h,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryColor, width: 0.5.w),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Quntity";
                    }
                    return null;
                  },
                ),
                // QuntityField(quntity),
                SizedBox(height: 1.5.h),
                // CategoryBox(),
                Container(
                  height: 60,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kGreyColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.5.h),
                // SubmitButton(_formField)
                GestureDetector(
                  onTap: () {
                    if (_formField.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddNewProductPage()));
                    }
                  },
                  child: Container(
                    // margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 10.h,
                    width: 370.w,
                    // margin: EdgeInsets,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kButtonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Submit",
                            style: GoogleFonts.abel(
                              letterSpacing: 2,
                              color: kTextBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 3.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      //
    );
  }
}
