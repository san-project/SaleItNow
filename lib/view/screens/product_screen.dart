import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/product_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:saleitnow/constants.dart';
import 'new_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getAllProducts(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Added Products",
          style: GoogleFonts.laila(
            color: kTextWhiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
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
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await provider.getAllProducts(context);
          },
          child: ListView.builder(
            // physics: const BouncingScrollPhysics(),

            itemCount: provider.listOfProducts.length,
            itemBuilder: (context, index) {
              final currentProduct = provider.listOfProducts[index];
              return ListTile(
                leading: Image.network(currentProduct.thumbnail.url),
                title: Text(currentProduct.name),
                subtitle: Text(currentProduct.description),
                isThreeLine: true,
                trailing: Text(currentProduct.price.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
