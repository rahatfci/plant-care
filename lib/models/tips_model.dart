class Tip {
  final String id;
  final String title;
  final String description;
  final String imgPath;

  Tip(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgPath});
  Map<String, dynamic> toJson(Tip tip) {
    return {
      'id': tip.id,
      'title': tip.title,
      'description': tip.description,
      'imgPath': tip.imgPath
    };
  }

  static Tip fromJson(data) {
    return Tip(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        imgPath: data['imgPath']);
  }
}
