import 'package:flutter/material.dart';

Widget buildTile(String text, int color, IconData icon, {int? count}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(color)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(count != null ? "$count" : "",
                    style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    icon,
                    color: Color(color),
                    size: 32,
                  ),
                  backgroundColor: Colors.white,
                )
              ],
            ),
            Text(text,
                style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold))
          ]),
    ),
  );
}
