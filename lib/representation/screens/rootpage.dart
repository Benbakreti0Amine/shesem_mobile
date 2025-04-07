import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Aboutus.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Buses_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Map_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Report_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/SosPage.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/alerts_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/guide_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/widgets/drawer.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const BusPage(),
    AlertsPage(),
    const MapPage(),
    const ReportScreen(),
    GuideScreen(),
  ];

  final List<BottomNavigationBarItem> _navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'حسابي',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notification_important_outlined),
      label: 'الرسائل',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.money_outlined),
      label: 'إستثمارات',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'الرئيسية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50), // Green color as shown in the image
        elevation: 0,
        automaticallyImplyLeading: false, // Remove default back button
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo "وفرة"

              Image.asset(
                'assets/images/logo.png',
                width: 90,
                height: 90,
              ),
              // Bell icon in white circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_outlined,
                      color: Color(0xFF4CAF50), size: 20),
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
              ),
            ],
          ),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 12.0,
              right: 10.0,
            ),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF69BB6D), 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: '...البحث عن خطة عمل',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Menu button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF69BB6D), // Lighter green for menu button
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white, size: 20),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _bottomIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: _navigationItems,
          currentIndex: _bottomIndex,
          selectedItemColor:
              Color(0xFF4CAF50), // Green color to match the app bar
          unselectedItemColor: Color(0xFF9DB2CE),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _bottomIndex = index;
            });
          },
        ),
      ),
    );
  }
}
