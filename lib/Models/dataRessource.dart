class CardModel {
  final String titre;
  final String tagHero;
  final String image;

  CardModel({
    this.titre,
    this.tagHero,
    this.image,
  });
}

class DataCard {

  static List<CardModel> _data = [
    CardModel(
      titre: 'Face Id',
      tagHero: 'faceId',
      image: 'images/icons8-reconnaissance-faciale-100.png',
    ),
    CardModel(
      titre: 'Touch ID',
      tagHero: 'touchId',
      image: 'images/icons8-empreinte-digitale-100.png',
    )
  ];

  static List<CardModel> getdata() => _data;
}