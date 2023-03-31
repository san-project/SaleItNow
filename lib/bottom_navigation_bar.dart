import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'view/screens/account_screen.dart';
import 'view/screens/product_screen.dart';
import 'view/screens/profitability_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    const ProfitabilityPage(),
    const ProductScreen(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: const Color(0xffebf1e6),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          gap: 8,
          backgroundColor: const Color(0xffebf1e6),
          color: Colors.grey.shade800,
          activeColor: Colors.black,
          tabBackgroundColor: const Color(0xffd9e7cb),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "Home",
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            GButton(
              icon: Icons.card_travel,
              text: "Products",
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            GButton(
              icon: Icons.person_outline,
              text: "Account",
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
