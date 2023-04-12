import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleitnow/providers/admin_provider.dart';
import 'package:saleitnow/providers/auth_provider.dart';
import 'package:saleitnow/view/screens/admin/seller_details_screen.dart';
import 'package:saleitnow/view/screens/auth/sign_in.dart';
import 'package:saleitnow/view/widgets/loading_widget.dart';

enum Menu { logout }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    log("in home initstate");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().getDashboardDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
              onPressed: () async {
                final shouldLogOut = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Log Out'),
                    content: const Text('Are you sure you want to log Out ?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('No'))
                    ],
                  ),
                );
                if ((shouldLogOut ?? false) == true && mounted) {
                  context
                      .read<AuthProvider>()
                      .logOut()
                      .then((value) => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SiginPage(),
                          ),
                          (route) => false));
                }
                log("logout");
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Consumer<AdminProvider>(
        builder: (_, adminProvider, __) {
          if (adminProvider.isLoading) {
            return const LoadingWidget();
          } else {
            return RefreshIndicator(
              edgeOffset: 10,
              onRefresh: () async {
                await adminProvider.getDashboardDetails();
              },
              child: GridView(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  _buildGridTile(
                    "Total Products",
                    adminProvider.dashboardDetails['noOfProducts'].toString(),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SellerManagementScreen(),
                    )),
                    child: _buildGridTile(
                      "Total Sellers",
                      adminProvider.dashboardDetails['noOfSeller'].toString(),
                    ),
                  ),
                  _buildGridTile(
                    "Total Aproved Sellers",
                    adminProvider.dashboardDetails['noOfApprovedSellers']
                        .toString(),
                  ),
                  _buildGridTile(
                    "Total Not Aproved Sellers",
                    adminProvider.dashboardDetails['noOfNotApprovedSellers']
                        .toString(),
                  ),
                  _buildGridTile(
                    "Total Users",
                    adminProvider.dashboardDetails['noOfUsers'].toString(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Card _buildGridTile(String text, String unit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              Text(unit),
            ],
          ),
        ),
      ),
    );
  }
}

class SellerManagementScreen extends StatefulWidget {
  const SellerManagementScreen({super.key});

  @override
  State<SellerManagementScreen> createState() => _SellerManagementScreenState();
}

class _SellerManagementScreenState extends State<SellerManagementScreen> {
  @override
  void initState() {
    log("in home initstate");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().getAllSellers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Sellers'),
      ),
      body: Consumer<AdminProvider>(
        builder: (_, adminProvider, __) {
          if (adminProvider.isLoading) {
            return const LoadingWidget();
          } else {
            return RefreshIndicator(
              edgeOffset: 10,
              onRefresh: () async {
                await adminProvider.getAllSellers(context);
              },
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: adminProvider.sellers.length,
                  itemBuilder: (context, index) {
                    final currentSeller = adminProvider.sellers[index];
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    SellerDetails(id: currentSeller.id))),
                        title: Text(currentSeller.businessName),
                        trailing: currentSeller.isApproved
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 28,
                              )
                            : null,
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
