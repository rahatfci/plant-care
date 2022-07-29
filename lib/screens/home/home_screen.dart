import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/components/body.dart';
import 'package:plant_watch/screens/login_sign_up/sign_up_screen.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_nav.dart';
import '../../components/nav_drawer.dart';
import '../cart/components/body.dart';
import '../categories/components/body.dart';
import '../settings/components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Widget> pages = [
    HomeBody(),
    CategoryBody(),
    FirebaseAuth.instance.currentUser == null ? SignUpScreen() : CartBody(),
    FirebaseAuth.instance.currentUser == null ? SignUpScreen() : SettingsBody()
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
      appBar: buildAppBar(context, scaffoldKey),
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: IndexedStack(
            index: HomeScreen.selectedIndex,
            children: HomeScreen.pages,
          )),
      bottomNavigationBar: myBottomNavBar(setState),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
