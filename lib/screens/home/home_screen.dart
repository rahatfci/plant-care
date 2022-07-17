import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/components/body.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_nav.dart';
import '../../components/nav_drawer.dart';
import '../cart/components/body.dart';
import '../categories/components/body.dart';
import '../settings/components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Widget> pages = const [
    HomeBody(),
    CategoryBody(),
    CartBody(),
    SettingsBody()
  ];

  static List<String> appBarTitle = const [
    "Home",
    "Category",
    "Cart",
    "Settings"
  ];

  static List<IconData> appBarIcons = const [
    Icons.dashboard_outlined,
    Icons.shopping_cart_outlined,
    Icons.category,
    Icons.settings,
  ];
  static int selectedIndex = 0;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(
          context,
          HomeScreen.appBarTitle[HomeScreen.selectedIndex],
          HomeScreen.appBarIcons[HomeScreen.selectedIndex],
          scaffoldKey),
      body: IndexedStack(
        index: HomeScreen.selectedIndex,
        children: HomeScreen.pages,
      ),
      bottomNavigationBar: myBottomNavBar(setState),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
