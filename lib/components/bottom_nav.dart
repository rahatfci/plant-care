import 'package:flutter/material.dart';
import 'package:plant_watch/screens/home/home_screen.dart';

Widget myBottomNavBar(Function setState) {
  void onItemTapped(int index) {
    setState(() {
      HomeScreen.selectedIndex = index;
    });
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(
        height: 2,
        thickness: 2,
      ),
      Container(
        padding: const EdgeInsets.only(top: 3, bottom: 12, left: 15, right: 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => onItemTapped(0),
              icon: HomeScreen.selectedIndex == 0
                  ? const Icon(
                      Icons.home,
                      color: Color(0xff096534),
                      size: 36,
                    )
                  : Icon(Icons.home_outlined,
                      color: const Color(0xff096534).withOpacity(.8), size: 36),
            ),
            IconButton(
              onPressed: () => onItemTapped(1),
              icon: HomeScreen.selectedIndex == 1
                  ? const Icon(Icons.event_note,
                      color: Color(0xff096534), size: 36)
                  : Icon(Icons.event_note_outlined,
                      color: const Color(0xff096534).withOpacity(.8), size: 36),
            ),
            IconButton(
              onPressed: () => onItemTapped(2),
              icon: HomeScreen.selectedIndex == 2
                  ? const Icon(Icons.shopping_cart,
                      color: Color(0xff096534), size: 36)
                  : Icon(Icons.shopping_cart_outlined,
                      color: const Color(0xff096534).withOpacity(.8), size: 36),
            ),
            IconButton(
              onPressed: () => onItemTapped(3),
              icon: HomeScreen.selectedIndex == 3
                  ? const Icon(Icons.settings,
                      color: Color(0xff096534), size: 36)
                  : Icon(Icons.settings_outlined,
                      color: const Color(0xff096534).withOpacity(.8), size: 36),
            ),
          ],
        ),
      ),
    ],
  );
}
