import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/models/category_model.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../providers/product_provider.dart';
import 'add_product_screen.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formField = GlobalKey<FormState>();
  late final TextEditingController _productName;
  late final TextEditingController _descriptionText;
  late final TextEditingController _price;
  late final TextEditingController _stock;
  // late final TextEditingController CategoryBox;
  String dropdownvalue = 'Item 1';
  // List<File> images = [];
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
    context.read<ProductProvider>().getAllCategoryFromRepo(context);
    _productName = TextEditingController();
    _descriptionText = TextEditingController();
    _price = TextEditingController();
    _stock = TextEditingController();
  }

  @override
  void dispose() {
    _productName.dispose();
    _descriptionText.dispose();
    _price.dispose();
    _stock.dispose();
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
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3),
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Consumer<ProductProvider>(
              builder: (context, provider, _) => Column(
                children: [
                  provider.pickedImages.isNotEmpty
                      ? CarouselSlider.builder(
                          itemCount: provider.pickedImages.length,
                          itemBuilder: (context, index, realIndex) => Stack(
                            children: [
                              Image.file(
                                provider.pickedImages[index],
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                              Positioned(
                                  top: 01.h,
                                  right: 01.h,
                                  child: Container(
                                      color: Colors.white.withOpacity(0.5),
                                      child: Text(
                                        '${index + 1}/${provider.pickedImages.length}',
                                      ))),
                            ],
                          ),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            provider.pickMultipleImages();
                          },
                          child: DottedBorder(
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            child: Container(
                              height: 20.h,
                              width: 370.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_outlined,
                                      color: Colors.black,
                                      size: 4.h,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Selete Product Image",
                                      style: GoogleFonts.abel(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 2.5.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 1.5.h),
                  //------------------------------Thumbnail---------------------------------------
                  GestureDetector(
                    onTap: () async {
                      provider.pickThumbnail();
                    },
                    child: Container(
                      height: 8.h,
                      // width: 90.5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(color: kGreyColor, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thumbnail",
                            style: GoogleFonts.abel(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                              fontSize: 2.5.h,
                            ),
                          ),
                          provider.thumbnail == null
                              ? Icon(
                                  Icons.insert_photo,
                                  color: Colors.black,
                                  size: 4.h,
                                )
                              : Image.file(provider.thumbnail!)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  TextFormField(
                    controller: _productName,
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

                  SizedBox(height: 1.5.h),
                  TextFormField(
                    controller: _descriptionText,
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
                    controller: _price,
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
                    controller: _stock,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Stock",
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
                        return "Enter stock";
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
                        child: DropdownButton<CategoryModel>(
                          isExpanded: true,
                          value: provider.selectedCategory,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: provider.categoryList.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name),
                            );
                          }).toList(),
                          onChanged: (categoryModel) {
                            provider.changeCategory(categoryModel);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  // SubmitButton(_formField)
                  SizedBox(
                    width: 100.w,
                    height: 12.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: provider.isLoading
                          ? null
                          : () {
                              final isValid =
                                  _formField.currentState!.validate();
                              if (!isValid) {
                                return;
                              }
                              provider.uploadProducts(
                                name: _productName.text,
                                description: _descriptionText.text,
                                price: double.parse(_price.text),
                                stock: int.parse(_stock.text),
                                context: context,
                              );
                            },
                      child: Visibility(
                        visible: !provider.isLoading,
                        replacement: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        child: Text(
                          "Upload",
                          style: GoogleFonts.laila(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     if (_formField.currentState!.validate()) {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => const AddNewProductPage()));
                  //     }
                  //   },
                  //   child: Container(
                  //     // margin: const EdgeInsets.only(top: 10, bottom: 10),
                  //     height: 10.h,
                  //     width: 370.w,
                  //     // margin: EdgeInsets,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: kButtonColor),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "Submit",
                  //             style: GoogleFonts.abel(
                  //               letterSpacing: 2,
                  //               color: kTextBlackColor,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 3.h,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),

      //
    );
  }
}
