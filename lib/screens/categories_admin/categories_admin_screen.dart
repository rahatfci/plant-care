import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/constants.dart';

import '../../components/nav_drawer.dart';
import 'components/body.dart';

class CategoriesAdminScreen extends StatefulWidget {
  const CategoriesAdminScreen({Key? key}) : super(key: key);

  @override
  _CategoriesAdminScreenState createState() => _CategoriesAdminScreenState();
}

class _CategoriesAdminScreenState extends State<CategoriesAdminScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppBar(
            context, "Categories(admin)", Icons.high_quality, scaffoldKey),
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
