import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tips_model.dart';

class TipsController {
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('tip');
  static Stream<List<Tip>> allTips() {
    return reference
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .map((event) => event.docs.map((e) => Tip.fromJson(e.data())).toList());
  }
}
