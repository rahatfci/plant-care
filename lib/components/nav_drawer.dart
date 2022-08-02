import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/auth.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FirebaseAuth.instance.currentUser != null
            ? FutureBuilder<bool>(
                future: isAdmin(),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          drawerHeader(),
                          drawerBodyItem(
                            icon: Icons.home,
                            text: "Home",
                            onTap: () {
                              HomeScreen.selectedIndex = 0;
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.event_note,
                            text: 'Categories',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/categories_admin') {
                                Navigator.pushNamed(
                                    context, '/categories_admin');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.category,
                            text: 'Products',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/products_admin') {
                                Navigator.pushNamed(context, '/products_admin');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.image,
                            text: 'Carousel',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/carousel_admin') {
                                Navigator.pushNamed(context, '/carousel_admin');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.lightbulb,
                            text: 'Tips',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/tips_admin') {
                                Navigator.pushNamed(context, '/tips_admin');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.info,
                            text: 'About Us',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/about_us') {
                                Navigator.pushNamed(context, '/about_us');
                              }
                            },
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "Copyright © 2022 PlantCare. All rights reserved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    } else {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          drawerHeader(),
                          drawerBodyItem(
                            icon: Icons.home,
                            text: "Home",
                            onTap: () {
                              HomeScreen.selectedIndex = 0;
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.event_note,
                            text: 'Categories',
                            onTap: () {
                              Navigator.pop(context);

                              if (HomeScreen.selectedIndex != 1) {
                                HomeScreen.selectedIndex = 1;
                                Navigator.pushNamed(context, '/');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.event_note,
                            text: 'Profile',
                            onTap: () {
                              Navigator.pop(context);
                              HomeScreen.selectedIndex = 3;
                              if (HomeScreen.selectedIndex != 3) {
                                Navigator.pushNamed(context, '/');
                              }
                            },
                          ),
                          const Divider(),
                          drawerBodyItem(
                            icon: Icons.info,
                            text: 'About Us',
                            onTap: () {
                              Navigator.pop(context);
                              if (ModalRoute.of(context)!.settings.name !=
                                  '/about_us') {
                                Navigator.pushNamed(context, '/about_us');
                              }
                            },
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "Copyright © 2022 PlantCare. All rights reserved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                })
            : ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  drawerHeader(),
                  drawerBodyItem(
                    icon: Icons.home,
                    text: "Home",
                    onTap: () {
                      HomeScreen.selectedIndex = 0;
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                  ),
                  const Divider(),
                  drawerBodyItem(
                    icon: Icons.event_note,
                    text: 'Categories',
                    onTap: () {
                      Navigator.pop(context);

                      if (HomeScreen.selectedIndex != 1) {
                        HomeScreen.selectedIndex = 1;
                        Navigator.pushNamed(context, '/');
                      }
                    },
                  ),
                  const Divider(),
                  drawerBodyItem(
                    icon: Icons.info,
                    text: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      if (ModalRoute.of(context)!.settings.name !=
                          '/about_us') {
                        Navigator.pushNamed(context, '/about_us');
                      }
                    },
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Copyright © 2022 PlantCare. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  )
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
        image: AssetImage("assets/forest.jpg"),
      )),
      child: Stack(
        children: const <Widget>[
          Positioned(
            child: Text("Welcome to Plant Care",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 3,
                    letterSpacing: 1)),
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
