class CarouselCustom {
  final String id;
  final String imgPath;
  final String? link;
  final String title;
  final String description;
  CarouselCustom(
      {required this.id,
      required this.imgPath,
      required this.link,
      required this.title,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'link': link,
      'title': title,
      'description': description
    };
  }

  static CarouselCustom fromJson(data) {
    return CarouselCustom(
        id: data['id'],
        imgPath: data['imgPath'],
        link: data['link'],
        title: data['title'],
        description: data['description']);
  }
}
