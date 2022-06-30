import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/components/bottom_nav.dart';
import 'package:plant_watch/components/nav_drawer.dart';

import '../settings/components/body.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "Setting", Icons.settings, scaffoldKey),
      body: Body(),
      bottomNavigationBar: const MyBottomNavBar(),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
