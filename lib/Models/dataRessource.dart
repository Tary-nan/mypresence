class CardModel {
  final String titre;
  final String tagHero;
  final String image;
  final String desc;

  CardModel({
    this.titre,
    this.tagHero,
    this.image,
    this.desc,
  });
}

class DataCard {

  static List<CardModel> _data = [
    CardModel(
      titre: 'Face Id',
      tagHero: 'faceId',
      image: 'images/icons8-reconnaissance-faciale-100.png',
      desc: "Utiliser le bouton du bas pour Le Face ID ",
    ),
    CardModel(
      titre: 'Touch ID',
      tagHero: 'touchId',
      image: 'images/icons8-empreinte-digitale-100.png',
      desc: "Utiliser le bouton du bas pour marquer votre emprunte ",
    )
  ];

  static List<CardModel> getdata() => _data;
}