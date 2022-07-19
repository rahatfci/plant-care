import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';

import '../../components/nav_drawer.dart';
import '../../constants.dart';
import 'components/body.dart';

class TipsAdminScreen extends StatefulWidget {
  const TipsAdminScreen({Key? key}) : super(key: key);

  @override
  State<TipsAdminScreen> createState() => _TipsAdminScreenState();
}

class _TipsAdminScreenState extends State<TipsAdminScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar:
            buildAppBar(context, "Tips(Admin)", Icons.image, scaffoldKey),
        body: const Body(),
        //bottomNavigationBar: const MyBottomNavBar(),
        drawer: const NavigationDrawer(),
        drawerEnableOpenDragGesture: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, right: 10),
          child: FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            backgroundColor: kPrimaryColor,
            elevation: 15,
          ),
        ),
      ),
    );
  }
}
