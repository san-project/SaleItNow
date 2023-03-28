import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'view/screens/account_screen.dart';
import 'view/screens/add_product_screen.dart';
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
    const AddNewProductPage(),
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






// import 'package:google_nav_bar/google_nav_bar.dart';
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
// class _BottomNavigationState extends State<BottomNavigation> {
//   int pageIndex = 0;
//   final HomePage _homePage = const HomePage();
//   final AccountPage _accountPage = const AccountPage();
//   final CategoriesPage _categoriesPage = const CategoriesPage();
//   final CartPage _cartPage = const CartPage();
//   Widget _showPage = const HomePage();
//   Widget _pageChooser(int page) {
//     switch (page) {
//       case 0:
//         return _homePage;
//         break;
//       case 1:
//         return _categoriesPage;
//         break;
//       case 2:
//         return _cartPage;
//         break;
//       case 3:
//         return _accountPage;
//         break;
//       default:
//         return const Text("NO page Found ");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: (
//         index: pageIndex,
//         height: 60.0,
//         backgroundColor: Colors.white,
//         color: Colors.black,
//         items: const [
//           Icon(
//             Icons.home_outlined,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.category_outlined,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.person_outline,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.shopping_cart_outlined,
//             color: Colors.white,
//             size: 30,
//           ),
//         ],
//         buttonBackgroundColor: Colors.black,
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 600),
//         onTap: (int tappedIndex) {
//           setState(() {
//             _showPage = _pageChooser(tappedIndex);
//           });
//         },
//         letIndexChange: (index) => true,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: _showPage,
//       ),
//     );
//   }
// }
