import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);
  static int index = 1;
  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 2,
          thickness: 2,
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 3, bottom: 12, left: 15, right: 15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    MyBottomNavBar.index = 1;
                  });
                  if (ModalRoute.of(context)!.settings.name != '/') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }
                },
                icon: MyBottomNavBar.index == 1
                    ? const Icon(
                        Icons.home,
                        color: Color(0xff096534),
                        size: 36,
                      )
                    : Icon(Icons.home_outlined,
                        color: const Color(0xff096534).withOpacity(.8),
                        size: 36),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    MyBottomNavBar.index = 2;
                  });
                  if (ModalRoute.of(context)!.settings.name != '/categories') {
                    Navigator.pushNamed(context, '/categories');
                  }
                },
                icon: MyBottomNavBar.index == 2
                    ? const Icon(Icons.event_note,
                        color: Color(0xff096534), size: 36)
                    : Icon(Icons.event_note_outlined,
                        color: const Color(0xff096534).withOpacity(.8),
                        size: 36),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    MyBottomNavBar.index = 3;
                  });
                  if (ModalRoute.of(context)!.settings.name != '/cart') {
                    Navigator.pushNamed(context, '/cart');
                  }
                },
                icon: MyBottomNavBar.index == 3
                    ? const Icon(Icons.shopping_cart,
                        color: Color(0xff096534), size: 36)
                    : Icon(Icons.shopping_cart_outlined,
                        color: const Color(0xff096534).withOpacity(.8),
                        size: 36),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    MyBottomNavBar.index = 4;
                  });
                  if (ModalRoute.of(context)!.settings.name != '/settings') {
                    Navigator.pushNamed(context, '/settings');
                  }
                },
                icon: MyBottomNavBar.index == 4
                    ? const Icon(Icons.settings,
                        color: Color(0xff096534), size: 36)
                    : Icon(Icons.settings_outlined,
                        color: const Color(0xff096534).withOpacity(.8),
                        size: 36),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
