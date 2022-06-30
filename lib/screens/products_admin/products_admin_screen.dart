import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';
import 'package:plant_watch/components/nav_drawer.dart';
import 'package:plant_watch/screens/products_admin/components/body.dart';

import '../../components/bottom_nav.dart';

class ProductsAdminScreen extends StatefulWidget {
  const ProductsAdminScreen({Key? key}) : super(key: key);

  @override
  State<ProductsAdminScreen> createState() => _ProductsAdminScreenState();
}

class _ProductsAdminScreenState extends State<ProductsAdminScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppBar(context, "Products(Admin)", Icons.category,
            GlobalKey<ScaffoldState>()),
        body: const Body(),
        bottomNavigationBar: const MyBottomNavBar(),
        drawer: const NavigationDrawer(),
        drawerEnableOpenDragGesture: false,
      ),
    );
  }
}
