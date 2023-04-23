import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
      final seller = provider.currentSeller;
      if (provider.isLoading || seller == null) {
        return const Material(
          child: LoadingWidget(),
        );
      } else {
        final currentSeller = seller;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Seller Details'),
              backgroundColor: Colors.purple[50],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailTile('Name', currentSeller.name.trim()),
                _buildDetailTile(
                    'Business Name', currentSeller.businessName.trim()),
                _buildDetailTile('Email', currentSeller.email.trim()),
                _buildDetailTile('Address', currentSeller.address.trim()),
                _buildDetailTile('Mobile', currentSeller.mobile.trim()),
                _buildDetailTile('Gst No.', currentSeller.gstNo.trim()),
                _buildDetailTile('Gst No.', currentSeller.createdAt.toString()),
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

  _buildDetailTile(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
