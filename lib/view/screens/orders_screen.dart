import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/models/order_model.dart';
import 'package:saleitnow/view/screens/order_detail_screen.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';

import '../../providers/seller_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: context.read<SellerProvider>().getAllOrders,
        child: Consumer<SellerProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            }
            if (provider.listOfOrders.isEmpty) {
              return const Center(
                child: Text('No Order Available'),
              );
            } else {
              provider.listOfOrders.sort(
                (b, a) => a.createdAt.compareTo(b.createdAt),
              );
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: provider.listOfOrders.length,
                  itemBuilder: (context, index) {
                    final currentOrder = provider.listOfOrders[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailScreen(orderId: currentOrder.id),
                          )),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentOrder.id),
                              const SizedBox(
                                height: 05,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Products ${currentOrder.products.length}\n₹ ${currentOrder.totalPrice}',
                                    style: const TextStyle(height: 1.5),
                                  ),
                                  const Spacer(),
                                  Text(
                                      'On: ${currentOrder.createdAt.day}/${currentOrder.createdAt.month}/${currentOrder.createdAt.year}\nStatus: ${currentOrder.status.value}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
