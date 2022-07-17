import 'package:flutter/material.dart';

import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(
          context, "Cart", Icons.shopping_cart_outlined, scaffoldKey),
      body: const CartBody(),
      //bottomNavigationBar: const MyBottomNavBar(),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
