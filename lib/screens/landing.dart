import 'package:flutter/material.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/screens/marketplace.dart';
import 'package:mobile_app/screens/transfers.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: new Icon(Icons.search),
        label: 'Marketplace',
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.info_outline), label: 'Token Transfers')
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomePage(),
        MarketplacePage(),
        TransfersPage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
