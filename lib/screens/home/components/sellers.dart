import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';

import '../../../controllers/sellers_controller.dart';
import '../../../models/seller_model.dart';

class Sellers extends StatefulWidget {
  const Sellers({Key? key}) : super(key: key);

  @override
  State<Sellers> createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Seller>>(
      stream: SellersController.allSellers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 125,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.map(buildSellers).toList(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
      },
    );
  }

  Widget buildSellers(Seller sellers) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: kTextColor)),
        child: Row(
          children: [
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        sellers.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        sellers.description,
                        style: TextStyle(
                            color: kTextColor.withOpacity(.8),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage(sellers.imgPath), fit: BoxFit.fill)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
