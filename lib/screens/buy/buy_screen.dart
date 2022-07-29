import 'package:flutter/material.dart';
import 'package:plant_watch/components/app_bar.dart';

import '../../components/nav_drawer.dart';
import 'components/body.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppBar(context, "Buy", Icons.category, scaffoldKey),
        body: const Body(),
        drawer: const NavigationDrawer(),
        drawerEnableOpenDragGesture: false,
      ),
    );
  }
}
