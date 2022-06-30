import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/components/nav_drawer.dart';

import '../category_details/components/body.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen(this.category, {Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, category, Icons.settings, scaffoldKey),
      body: Body(category),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
