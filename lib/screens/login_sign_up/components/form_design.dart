import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';

Widget topStyle(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 2.5,
    color: kPrimaryColor,
    width: MediaQuery.of(context).size.width,
  );
}

Widget welcomeText() {
  return const Positioned(
    top: 80,
    left: 20,
    child: Text(
      "Welcome !",
      style:
          TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Poppins'),
    ),
  );
}

Widget orDivider(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Stack(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.black,
              height: 1.5,
              width: MediaQuery.of(context).size.width / 3.5,
            )),
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Or",
            style: TextStyle(
                height: .5, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.black,
              height: 1.5,
              width: MediaQuery.of(context).size.width / 3.5,
            ))
      ],
    ),
  );
}

Widget gLogin({required String text}) {
  return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF4285F4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Image.asset(
              "assets/g-logo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ));
}

Widget fbLogin({required String text}) {
  return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF0072E7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 10),
            child: Image.asset(
              "assets/f-logo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ));
}
