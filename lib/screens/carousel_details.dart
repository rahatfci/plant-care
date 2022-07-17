import 'package:flutter/material.dart';
import 'package:plant_watch/models/carousel_model.dart';

import '../../components/app_bar.dart';
import '../../components/nav_drawer.dart';
import '../../constants.dart';

class CarouselDetails extends StatefulWidget {
  const CarouselDetails(this.carousel, {Key? key}) : super(key: key);
  final CarouselCustom carousel;
  @override
  State<CarouselDetails> createState() => _CarouselDetailsState();
}

class _CarouselDetailsState extends State<CarouselDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "Details", Icons.settings, scaffoldKey),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: widget.carousel.id,
              child: Image.asset(
                widget.carousel.imgPath,
                height: 300,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.carousel.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    widget.carousel.description,
                                    style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        color: kTextColor.withOpacity(.8),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}
