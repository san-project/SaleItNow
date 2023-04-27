import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/seller_provider.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
import '../../data/models/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SellerProvider>().getOrderById(widget.orderId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey);
    final textTheme = Theme.of(context).textTheme;
    final borderDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<SellerProvider>().getOrderById(widget.orderId);
          },
          child: Consumer<SellerProvider>(builder: (context, provider, child) {
            final order = provider.currentOrder;
            if (provider.isLoading || order == null) {
              return const LoadingWidget();
            }
            return Container(
              height: SizerUtil.height,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListView(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Order Id # ',
                            style: textTheme.titleSmall
                                ?.copyWith(color: Colors.grey)),
                        TextSpan(text: order.id, style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Products',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ...order.products.map((e) => Container(
                        height: 130,
                        width: SizerUtil.width,
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: borderDecoration.borderRadius!,
                            side: borderDecoration.border!.bottom,
                          ),
                          leading: SizedBox(
                              height: 90,
                              width: 60,
                              child: CachedNetworkImage(
                                  imageUrl: e.product.thumbnail.url)),
                          title: Text(
                            e.product.name,
                            style: textTheme.titleMedium,
                            maxLines: 2,
                          ),
                          subtitle: Text(
                            'Qty: ${e.quantity} x ${e.product.price}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                            '₹ ${e.quantity * e.product.price}',
                            style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.teal.shade600),
                          ),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: borderDecoration,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              'Order Date',
                              style: labelStyle,
                            ),
                            Text(
                                '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}')
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Order Total',
                              style: labelStyle,
                            ),
                            Text('₹ ${order.totalPrice}')
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Buyer Name',
                              style: labelStyle,
                            ),
                            Text(order.buyer.name)
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Buyer Email',
                              style: labelStyle,
                            ),
                            Text(order.buyer.email)
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Shipping Address',
                              style: labelStyle,
                            ),
                            Text(order.deliveryAddress)
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Order Status',
                              style: labelStyle,
                            ),
                            Text(order.status.value),
                          ],
                        ),
                      ],
                    ),
                  ),
                  order.status == OrderStatus.cancel ||
                          order.status == OrderStatus.delivered
                      ? const SizedBox()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade400,
                              foregroundColor: Colors.white,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            final status = await showDialog<OrderStatus>(
                                context: context,
                                builder: (context) {
                                  OrderStatus currentStatus = order.status;
                                  return AlertDialog(
                                    content: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<OrderStatus>(
                                              value: currentStatus,
                                              alignment: Alignment.center,
                                              hint: const Text('Category'),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: OrderStatus.values
                                                  .map((status) {
                                                return DropdownMenuItem(
                                                  value: status,
                                                  child: Text(status.value),
                                                );
                                              }).toList(),
                                              onChanged: (status) {
                                                if (status == null) {
                                                  return;
                                                }
                                                setState(() {
                                                  currentStatus = status;
                                                });
                                              },
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(currentStatus);
                                            },
                                            child: const Text('Update'),
                                          )
                                        ],
                                      );
                                    }),
                                  );
                                });
                            if (status != null &&
                                order.status != status &&
                                context.mounted) {
                              context
                                  .read<SellerProvider>()
                                  .updateOrderById(order.id, status.value);
                            }
                          },
                          child: const Text('Update Order Status'),
                        )
                ],
              ),
            );
          }),
        ));
  }
}
