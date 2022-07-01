import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        drawerHeader(),
        drawerBodyItem(
          icon: Icons.home,
          text: "Home",
          onTap: () {
            if (ModalRoute.of(context)!.settings.name != '/') {
              Navigator.pushNamed(context, '/');
            }
          },
        ),
        const Divider(),
        drawerBodyItem(
          icon: Icons.event_note,
          text: 'Categories',
          onTap: () {
            Navigator.pop(context);
            if (ModalRoute.of(context)!.settings.name != '/categories_admin') {
              Navigator.pushNamed(context, '/categories_admin');
            }
          },
        ),
        const Divider(),
        drawerBodyItem(
          icon: Icons.category,
          text: 'Products',
          onTap: () {
            Navigator.pop(context);
            if (ModalRoute.of(context)!.settings.name != '/products_admin') {
              Navigator.pushNamed(context, '/products_admin');
            }
          },
        ),
        const Divider(),
        drawerBodyItem(
          icon: Icons.shopping_cart,
          text: 'Cart',
          onTap: () {
            Navigator.pop(context);
            if (ModalRoute.of(context)!.settings.name != '/cart') {
              Navigator.pushNamed(context, '/cart');
            }
          },
        ),
        const Divider(),
        drawerBodyItem(
          icon: Icons.account_circle,
          text: 'Sellers',
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "It's under construction. Stay tuned",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: kPrimaryColor,
              ),
            );
          },
        ),
      ],
    ));
  }

  Widget drawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage("assets/images/forest.jpg"),
      )),
      child: Stack(
        children: const <Widget>[
          Positioned(
            child: Text("Welcome to Plant Watch",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            left: 16,
            bottom: 12,
          )
        ],
      ),
    );
  }

  Widget drawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(text!))
        ],
      ),
      onTap: onTap,
    );
  }
}