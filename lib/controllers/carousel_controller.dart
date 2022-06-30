import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/carousel_model.dart';

class CarouselControllerCustom {
  static Stream<List<CarouselCustom>> allCarousel() {
    final CollectionReference reference =
        FirebaseFirestore.instance.collection('carousel');
    return reference.snapshots().map((event) =>
        event.docs.map((e) => CarouselCustom.fromJson(e.data())).toList());
  }
}
