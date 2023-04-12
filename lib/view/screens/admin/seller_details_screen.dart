import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/data/models/seller_model.dart';
import 'package:saleitnow/providers/admin_provider.dart';

import '../../widgets/loading_widget.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails({super.key, required this.id});
  final String id;

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  @override
  void initState() {
    log("in home initstate");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().getSellerDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Material(
          child: LoadingWidget(),
        );
      } else {
        final currentSeller = provider.currentSeller!;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Seller Details'),
              backgroundColor: Colors.purple[50],
            ),
            body: Column(
              children: [
                Text("name: \n${currentSeller.name}"),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: currentSeller.isApproved
                ? null
                : ElevatedButton(
                    onPressed: () {
                      context.read<AdminProvider>().approveSeller(widget.id);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          'Approve this seller',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ));
      }
    });
  }
}
