import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:saleitnow/providers/product_provider.dart';
import 'package:saleitnow/view/screens/product_detail_screen.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';
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
      if (context.read<ProductProvider>().listOfProducts.isEmpty) {
        context.read<ProductProvider>().getAllProducts(context);
        context.read<ProductProvider>().getAllCategoryFromRepo(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Added Products",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              // color: Colors.white,
              // size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: kPrimaryColor,
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
        builder: (context, provider, _) => Visibility(
          visible: !provider.isLoading,
          replacement: const LoadingWidget(),
          child: RefreshIndicator(
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
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(item: currentProduct),
                  )),
                  leading: Image.network(currentProduct.thumbnail.url),
                  title: Text(currentProduct.name),
                  subtitle: Text(
                    currentProduct.description,
                    maxLines: 2,
                  ),
                  isThreeLine: true,
                  trailing: Text(currentProduct.price.toString()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
