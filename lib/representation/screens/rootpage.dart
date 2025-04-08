import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/Formoverlay.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/ChatScreen.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Home_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Map_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Report_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/alerts_page.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  int _bottomIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // FAB menu state and controller
  bool _isFabMenuOpen = false;
  late AnimationController _fabController;

  // Form visibility states
  bool _showInvestmentForm = false;
  bool _showReportForm = false;
  bool _showMapForm = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomePage(),
    AlertsPage(),
    const ProfilePage(),
     Homme(),
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

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
      if (_isFabMenuOpen) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    });
  }

  void _closeFabMenu() {
    setState(() {
      _isFabMenuOpen = false;
      _fabController.reverse();
    });
  }

  void _handleFabAction(String action) {
    _closeFabMenu();
    if (action == 'investment') {
      setState(() {
        _showInvestmentForm = true;
      });
    } else if (action == 'report') {
      setState(() {
        _showReportForm = true;
      });
    } else if (action == 'map') {
      setState(() {
        _showMapForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF43A700),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 90,
                height: 90,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          IndexedStack(
            index: _bottomIndex,
            children: _pages,
          ),

          // Overlay for FAB menu
          if (_isFabMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeFabMenu,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7, 0.9, 1.0],
                    ),
                  ),
                ),
              ),
            ),

          // FAB menu items
          if (_isFabMenuOpen)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FabMenuItem(
                      icon: Icons.monetization_on_outlined,
                      label: 'البحث عن مستثمر',
                      onTap: () => _handleFabAction('investment'),
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 16),
                    FabMenuItem(
                      icon: Icons.map_outlined,
                      label: ' بيع فرصة عمل',
                      onTap: () => _handleFabAction('map'),
                      color: const Color(0xFF4CAF50),
                    ),
                  ],
                ),
              ),
            ),

          // Form overlays
          if (_showInvestmentForm)
            FormOverlay(
              title:  'البحث عن مستثمر',
              onClose: () => setState(() => _showInvestmentForm = false),
            ),

          if (_showMapForm)
            FormOverlay(
              title:' بيع فرصة عمل',
              onClose: () => setState(() => _showMapForm = false),
            ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
          animation: _fabController,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.all(0),
              height: 51.0, // Smaller size
              width: 51.0, // Smaller size to make it circular
              child: FloatingActionButton(
                backgroundColor: Color(0xFF4CAF50),
                onPressed: _toggleFabMenu,
                shape: const CircleBorder(
                  side: BorderSide(color: Color(0xFFBAFFA7), width: 2.0),
                ), // Circle with yellow border
                child: Transform.rotate(
                  angle:
                      _fabController.value * 0.5 * 3.14, // Rotate from + to X
                  child: Icon(
                    _isFabMenuOpen ? Icons.close : Icons.add,
                    color: Colors.white,
                    size: 25.0, // Smaller icon size to match smaller FAB
                  ),
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: _navigationItems,
          currentIndex: _bottomIndex,
          selectedItemColor: Color(0xFF4CAF50),
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
              if (_isFabMenuOpen) {
                _closeFabMenu();
              }
            });
          },
        ),
      ),
    );
  }
}

// Custom widget for FAB menu items
class FabMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const FabMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

