import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselSlider, CarouselOptions;
import 'package:saleitnow/view/screens/edit_product.dart';
import 'package:sizer/sizer.dart';
import '../../data/models/get_product_model.dart' show ProductModel;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.item});
  final ProductModel item;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool isFavourite;
  int _curernt = 0;
  late final List<String> _images;
  late bool isAddedToCart;
  @override
  void initState() {
    _images = widget.item.images.map((e) => e.url).toList();
    _images.insert(0, widget.item.thumbnail.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
              width: 100.w,
              child: Stack(
                children: [
                  SizedBox(
                    width: SizerUtil.width,
                    child: CarouselSlider(
                      items: _images
                          .map((e) => CachedNetworkImage(imageUrl: e))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _curernt = index;
                            });
                          }),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _images.map((url) {
                        int index = _images.indexOf(url);
                        return Container(
                          width: 1.h,
                          height: 1.h,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0.1),
                            color:
                                _curernt == index ? Colors.white : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                            shape: const CircleBorder()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.1.h,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffe5e5e9),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 04.w, vertical: 01.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.name,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "₹ ${widget.item.price}",
                          style: TextStyle(
                              color: Colors.orange[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(widget.item.description),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductScreen(product: widget.item),
              ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
