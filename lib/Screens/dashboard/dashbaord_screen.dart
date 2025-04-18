import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_aggregator_app/Screens/bill_board_controller.dart';
import 'package:news_aggregator_app/Screens/home/home_screen.dart';
import 'package:news_aggregator_app/Screens/search_page/search_news.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const SearchNewsPage(),
    const ControllerPage(),
  ];
  @override
  Widget build(BuildContext context) {
    String appBarTitle;

    switch (_selectedIndex) {
      case 0:
        appBarTitle = 'Home';
        break;
      case 1:
        appBarTitle = 'Search';
        break;
      case 2:
        appBarTitle = 'Profile';
        break;
      default:
        appBarTitle = 'Home';
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'UrbanistBold',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person_2,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: screens[_selectedIndex],
    );
  }
}
