class User {
  String contacts;
  String userUsername;
  String userLastName;
  String userFirstName;
  bool userIsSuperuser;
  String genre;
  String userEmail;
  String image;

  User({
    this.contacts,
    this.userUsername,
    this.userLastName,
    this.userFirstName,
    this.userIsSuperuser,
    this.genre,
    this.userEmail,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    contacts: json["contacts"] == null ? null : json["contacts"],
    userUsername: json["user__username"] == null ? null : json["user__username"],
    userLastName: json["user__last_name"] == null ? null : json["user__last_name"],
    userFirstName: json["user__first_name"] == null ? null : json["user__first_name"],
    userIsSuperuser: json["user__is_superuser"] == null ? null : json["user__is_superuser"],
    genre: json["genre"] == null ? null : json["genre"],
    userEmail: json["user__email"] == null ? null : json["user__email"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "contacts": contacts == null ? null : contacts,
    "user__username": userUsername == null ? null : userUsername,
    "user__last_name": userLastName == null ? null : userLastName,
    "user__first_name": userFirstName == null ? null : userFirstName,
    "user__is_superuser": userIsSuperuser == null ? null : userIsSuperuser,
    "genre": genre == null ? null : genre,
    "user__email": userEmail == null ? null : userEmail,
    "image": image == null ? null : image,
  };
}
