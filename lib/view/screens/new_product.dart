import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/models/category_model.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../providers/product_provider.dart';

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
  late final ProductProvider _provider;
  late final TextEditingController _category;

  late final TextEditingController _brand;
  // late final TextEditingController CategoryBox;

  // List<File> images = [];

  @override
  void initState() {
    super.initState();
    log("in initstate of New Product");
    _provider = Provider.of<ProductProvider>(context, listen: false);
    // context.read<ProductProvider>().getAllCategoryFromRepo(context);
    _brand = TextEditingController();
    _productName = TextEditingController();
    _descriptionText = TextEditingController();
    _category = TextEditingController();
    _price = TextEditingController();
    _stock = TextEditingController();
  }

  @override
  void dispose() {
    _provider.clearImages();
    _productName.dispose();
    _descriptionText.dispose();
    _price.dispose();
    _stock.dispose();
    _brand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Products",
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
                          borderRadius: BorderRadius.circular(12),
                          color: kFilledColor),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Thumbnail",
                            style: TextStyle(color: Colors.grey),
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
                    decoration: const InputDecoration(
                      labelText: "Product Name",
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
                    decoration: const InputDecoration(
                      labelText: "Description",
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
                    decoration: const InputDecoration(
                      labelText: "Price",
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
                    decoration: const InputDecoration(
                      labelText: "Stock",
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
                  TextFormField(
                    controller: _brand,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Brand",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter brand";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15.w,
                        width: 74.w,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kFilledColor,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CategoryModel>(
                            isExpanded: true,
                            value: provider.selectedCategory,
                            hint: const Text('Category'),
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
                      InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showUploadCategoryBottomSheet();
                        },
                        child: Container(
                          height: 15.w,
                          width: 15.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: kFilledColor,
                          ),
                          child: const Icon(Icons.add),
                        ),
                      )
                    ],
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
                              if (provider.selectedCategory == null) {
                                Fluttertoast.showToast(
                                    msg: "please select category");
                                return;
                              }
                              provider.uploadProducts(
                                name: _productName.text,
                                description: _descriptionText.text,
                                price: double.parse(_price.text),
                                stock: int.parse(_stock.text),
                                brand: _brand.text,
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

  showUploadCategoryBottomSheet() {
    showBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        color: Colors.white,
        height: 30.h,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add New Category'),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: _category,
              enabled: true,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                filled: true,
                fillColor: Colors.green,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      foregroundColor: Colors.white),
                  onPressed: () {},
                  child: const Text('Add')),
            )
          ],
        ),
      ),
    );
  }
}
