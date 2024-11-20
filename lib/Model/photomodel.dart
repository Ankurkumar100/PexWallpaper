class Photomodel {
  String imgSrc;
  String photoman;
  Photomodel({required this.imgSrc, required this.photoman});
  static Photomodel fromAPIApp(Map<String, dynamic> photomap) {
    return Photomodel(
        imgSrc: (photomap["src"])["portrait"],
        photoman: photomap["photographer"]);
  }
}
