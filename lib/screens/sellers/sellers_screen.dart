import 'package:flutter/material.dart';

import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import 'components/body.dart';

class SellerScreen extends StatelessWidget {
  SellerScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "Sellers", Icons.person, scaffoldKey),
      body: const Body(),
      //bottomNavigationBar: const MyBottomNavBar(),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
