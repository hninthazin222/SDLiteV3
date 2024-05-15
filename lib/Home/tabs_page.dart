import 'package:flutter/material.dart';
import 'package:sdlite/Home/home_page.dart';
import 'package:sdlite/style.dart';

class TabsPage extends StatefulWidget {
  final int currentIndex;
  const TabsPage({
    super.key,
    required this.currentIndex,
  });

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int selectedIndex = 0;

  _page() {
    if (selectedIndex == 0) {
      return const HomePage();
    } else if (selectedIndex == 1) {
      return Container();
    } else if (selectedIndex == 2) {
      return Container();
    } else if (selectedIndex == 3) {
      return Container();
    } else if (selectedIndex == 4) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: mainColor,
        unselectedItemColor: const Color(0xFF6B7280),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: "Tesks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: "Inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Customers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: "More",
          ),
        ],
      ),
    );
  }
}
