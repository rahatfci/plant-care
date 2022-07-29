import 'package:flutter/material.dart';
import '../../authentication/auth.dart';
import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import 'components/body.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool admin = false;
  @override
  void initState() {
    super.initState();
    if (admin) {
      Navigator.pushReplacementNamed(context, '/sign_up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, scaffoldKey),
      body: const CartBody(),
      //bottomNavigationBar: const MyBottomNavBar(),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
